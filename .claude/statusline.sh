#!/bin/sh
# Claude Code status line.
#   Line 1: model (effort), context, directory:branch, worktree, PR
#   Line 2: rate-limit meters (5h, 7d), cost, prompt cache, version
#
# The field variables (model, ctx, five, week, …) are assigned by the `eval` of
# jq output below; shellcheck can't trace that, so silence its false positive:
# shellcheck disable=SC2154
input=$(cat)

# --- ANSI colors (bright variants survive terminal dimming) ---
RESET=$(printf '\033[0m')
RED=$(printf '\033[91m')
GREEN=$(printf '\033[92m')
YELLOW=$(printf '\033[93m')

# --- Parse every field in one jq pass; @sh keeps values shell-safe ---
eval "$(printf '%s' "$input" | jq -r '
  def num: if type == "number" then floor else "" end;   # epoch seconds / counts; else unavailable
  {
    model:   (.model.display_name                       // "Unknown"),
    effort:  (.effort.level                             // ""),
    version: (.version                                  // ""),
    ctx:     (.context_window.used_percentage           // 0),
    five:    (.rate_limits.five_hour.used_percentage    // ""),
    five_at: (.rate_limits.five_hour.resets_at          // ""),
    week:    (.rate_limits.seven_day.used_percentage    // ""),
    week_at: (.rate_limits.seven_day.resets_at          // ""),
    dir:     (.workspace.current_dir                    // ""),
    wt:      (.workspace.git_worktree // .worktree.name // ""),
    pr:      (.pr.number                                // ""),
    cost:    (.cost.total_cost_usd                      // ""),
    c_exp:   (.prompt_cache.expires_at                  | num),
    c_cold:  (.prompt_cache.recache_tokens_if_cold      | num),
    c_miss:  (.prompt_cache.misses                      | num),
    c_req:   (.prompt_cache.requests                    | num),
    c_last:  (.prompt_cache.last_miss_at                | num),
    c_cause: ((.prompt_cache.last_miss_cause.causes     # tools_changed -> tools
               | map(strings | sub("_changed$"; "") | sub("^likely_"; "") | gsub("_"; " "))
               | join("+"))? // "")
  } | to_entries[] | "\(.key)=\(.value | tostring | @sh)"
')"

_now=$(date +%s)

# pct_color <pct> — traffic-light color for a usage percentage: green / yellow / red
pct_color() {
  if   [ "$1" -ge 85 ]; then printf '%s' "$RED"
  elif [ "$1" -ge 60 ]; then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"
  fi
}

# dec <tenths> <unit> — "X.Yunit" with ".0" trimmed when exact: 43 h -> "4.3h", 40 h -> "4h"
dec() {
  _f=$(( $1 % 10 ))
  if [ "$_f" -eq 0 ]; then printf '%d%s' "$(( $1 / 10 ))" "$2"
  else printf '%d.%d%s' "$(( $1 / 10 ))" "$_f" "$2"; fi
}

# duration_str <seconds> — compact duration for countdowns and ages:
#   "X.Yd" (>= 1d) / "X.Yh" (>= 1h) / "Nm", rounded to nearest; ".0" is
#   trimmed ("4h" not "4.0h"). "0m" if <= 0.
duration_str() {
  _secs=$1
  [ "$_secs" -le 0 ] && { printf '0m'; return; }
  if [ "$_secs" -ge 86400 ]; then
    dec "$(( (_secs + 4320) / 8640 ))" d   # tenths of a day, rounded
  elif [ "$_secs" -ge 3600 ]; then
    dec "$(( (_secs + 180) / 360 ))" h     # tenths of an hour, rounded
  else
    printf '%dm' "$(( (_secs + 30) / 60 ))" # whole minutes, rounded
  fi
}

# meter <label> <pct> <resets_at>
#   Returns "Label:<bar> NN% in ..." — empty when <pct> is empty.
#   The label is uncolored; the bar and percentage are green < 60%, yellow >= 60%, red >= 85%.
meter() {
  _label=$1; _raw=$2; _resets=$3
  [ -n "$_raw" ] || return 0
  _int=$(printf '%.0f' "$_raw")    # rounded int drives the color and bar
  _pct=$(printf '%.1f' "$_raw")    # shown value: one decimal,
  _pct=${_pct%.0}                  # trimmed to a whole number when exact
  _pcolor=$(pct_color "$_int")
  _reset=""
  [ -n "$_resets" ] && _reset=" in $(duration_str $(( _resets - _now )))"
  printf '%s:%s%s %s%%%s%s' "$_label" "$_pcolor" "$(bar "$_int")" "$_pct" "$RESET" "$_reset"
}

# tokens_str <count> — token count in thousands, rounded: 73612 -> "74k"
tokens_str() {
  printf '%dk' "$(( ($1 + 500) / 1000 ))"
}

# bar <pct> — 10-cell progress bar, one cell per 10% (rounded): 24 -> "██░░░░░░░░"
bar() {
  _i=0
  while [ "$_i" -lt 10 ]; do
    if [ "$_i" -lt $(( ($1 + 5) / 10 )) ]; then printf '█'; else printf '░'; fi
    _i=$(( _i + 1 ))
  done
}

# add <segment> — append <segment> to $row with a " | " separator (skip empty)
add() {
  [ -n "$1" ] && row="${row:+$row | }$1"
}

# === Line 1: model, context, directory:branch, worktree, PR ===
branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
case "$dir" in                                   # abbreviate home to ~ (after git lookup)
  "$HOME")   dir="~" ;;
  "$HOME"/*) dir="~${dir#"$HOME"}" ;;
esac

row=$model
[ -n "$effort" ] && row="$row ($effort)"
ctx=$(printf '%.0f' "$ctx")
add "Ctx:$(pct_color "$ctx")$(bar "$ctx") $ctx%$RESET"
add "$dir${branch:+:$branch}"
add "${wt:+wt:$wt}"
add "${pr:+#$pr}"
line1=$row

# === Line 2: rate-limit meters (5h, 7d), cost, prompt cache, version ===
row=""
add "$(meter 5h  "$five" "$five_at")"
add "$(meter 7d  "$week" "$week_at")"
add "${cost:+$(printf '$%.2f' "$cost")}"

# Cache: <Nm left | expired (~Nk to recache) | N/A>[, N/M misses][ (cause, Nm ago)]
if [ -z "$c_exp" ]; then cache="N/A"
elif [ "$c_exp" -gt "$_now" ]; then cache="$GREEN$(duration_str $(( c_exp - _now ))) left$RESET"
else cache="${YELLOW}expired$RESET${c_cold:+ (~$(tokens_str "$c_cold") to recache)}"
fi
[ -n "$c_miss" ] && [ -n "$c_req" ] && cache="$cache, $c_miss/$c_req misses"
c_age=$(( _now - ${c_last:-0} ))
[ -n "$c_last" ] && [ "$c_age" -ge 0 ] &&
  cache="$cache (${c_cause:+$c_cause, }$(duration_str "$c_age") ago)"
add "Cache: $cache"

add "${version:+v$version}"
line2=$row

# --- Emit (second line only when non-empty) ---
output=$line1
[ -n "$line2" ] && output="$output
$line2"
printf '%s' "$output"
