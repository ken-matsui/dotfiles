#!/bin/sh
# Claude Code status line.
#   Line 1: model (effort), version, directory:branch, worktree
#   Line 2: context + rate-limit meters (Ctx, 5h, 7d), cost
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
  {
    model:   (.model.display_name                       // "Unknown"),
    effort:  (.effort.level                             // ""),
    version: (.version                                  // ""),
    ctx:     (.context_window.used_percentage           // 0),
    ctx_tok: ((.context_window.total_input_tokens       // 0)
            + (.context_window.total_output_tokens      // 0)),
    five:    (.rate_limits.five_hour.used_percentage    // ""),
    five_at: (.rate_limits.five_hour.resets_at          // ""),
    week:    (.rate_limits.seven_day.used_percentage    // ""),
    week_at: (.rate_limits.seven_day.resets_at          // ""),
    dir:     (.workspace.current_dir                    // ""),
    wt:      (.workspace.git_worktree // .worktree.name // ""),
    cost:    (.cost.total_cost_usd                      // "")
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

# duration_str <epoch> — time until <epoch> for the "in ..." reset countdown:
#   "X.Yd" (>= 1d) / "X.Yh" (>= 1h) / "Nm", rounded to nearest; ".0" is
#   trimmed ("4h" not "4.0h"). "0m" if past.
duration_str() {
  _secs=$(( $1 - _now ))
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
#   Returns "Label:NN% in ..." — empty when <pct> is empty.
#   The label is uncolored; the percentage is green < 60%, yellow >= 60%, red >= 85%.
meter() {
  _label=$1; _raw=$2; _resets=$3
  [ -n "$_raw" ] || return 0
  _int=$(printf '%.0f' "$_raw")    # rounded int drives the percentage color
  _pct=$(printf '%.1f' "$_raw")    # shown value: one decimal,
  _pct=${_pct%.0}                  # trimmed to a whole number when exact
  _pcolor=$(pct_color "$_int")
  _reset=""
  [ -n "$_resets" ] && _reset=" in $(duration_str "$_resets")"
  printf '%s:%s%s%%%s%s' "$_label" "$_pcolor" "$_pct" "$RESET" "$_reset"
}

# tokens_str <count> — token count in thousands, rounded: 73612 -> "74k"
tokens_str() {
  printf '%dk' "$(( ($1 + 500) / 1000 ))"
}

# add <segment> — append <segment> to $row with a " | " separator (skip empty)
add() {
  [ -n "$1" ] && row="${row:+$row | }$1"
}

# === Line 1: model, version, directory:branch, worktree ===
branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
case "$dir" in                                   # abbreviate home to ~ (after git lookup)
  "$HOME")   dir="~" ;;
  "$HOME"/*) dir="~${dir#"$HOME"}" ;;
esac

row=$model
[ -n "$effort" ] && row="$row ($effort)"
add "${version:+v$version}"
add "$dir${branch:+:$branch}"
add "${wt:+wt:$wt}"
line1=$row

# === Line 2: context + rate-limit meters (Ctx, 5h, 7d), cost ===
row=""
ctx=$(printf '%.0f' "$ctx")
add "Ctx:$(tokens_str "$ctx_tok") ($(pct_color "$ctx")$ctx%$RESET)"
add "$(meter 5h  "$five" "$five_at")"
add "$(meter 7d  "$week" "$week_at")"
add "${cost:+$(printf '$%.4f' "$cost")}"
line2=$row

# --- Emit (second line only when non-empty) ---
output=$line1
[ -n "$line2" ] && output="$output
$line2"
printf '%s' "$output"
