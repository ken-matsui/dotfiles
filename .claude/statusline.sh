#!/bin/sh
# Claude Code status line.
#
# The in_* variables are assigned by the `eval` of jq output below;
# shellcheck can't trace that, so silence its false positive:
# shellcheck disable=SC2154
set -eu

# Parse every field in one jq pass; @sh keeps values shell-safe
_assignments=$(jq -er '
  def int: floor? // "";
  {
    model:      (.model.display_name                    // "Unknown"),
    effort:     (.effort.level                          // ""),
    version:    (.version                               // ""),
    ctx:        (.context_window.used_percentage        // 0),
    ctx_tokens: (.context_window.total_input_tokens     | int),
    ctx_size:   (.context_window.context_window_size    | int),
    five:       (.rate_limits.five_hour.used_percentage // ""),
    five_at:    (.rate_limits.five_hour.resets_at       | int),
    week:       (.rate_limits.seven_day.used_percentage // ""),
    week_at:    (.rate_limits.seven_day.resets_at       | int),
    dir:        (.workspace.current_dir                 // ""),
    cost:       (.cost.total_cost_usd                   // ""),
    c_observed: (.prompt_cache.caching_observed         == true),
    c_exp:      (.prompt_cache.expires_at               | int),
    c_cold:     (.prompt_cache.recache_tokens_if_cold   | int),
    c_miss:     (.prompt_cache.misses                   | int),
    c_req:      (.prompt_cache.requests                 | int),
    c_last:     (.prompt_cache.last_miss_at             | int),
    c_cause:    (.prompt_cache.last_miss_cause.causes   // [] | join(" + ") | gsub("_"; " "))
  } | to_entries[] | "in_\(.key)=\(.value | tostring | @sh)"
')
eval "$_assignments"

# Constants
RESET=$( printf '\033[0m')
RED=$(   printf '\033[91m')
GREEN=$( printf '\033[92m')
YELLOW=$(printf '\033[93m')
NOW=$(   date +%s)

# pct_color <pct> — traffic-light color for a usage percentage: green / yellow / red
pct_color() {
  if   [ "$1" -ge 85 ]; then
    printf '%s' "$RED"
  elif [ "$1" -ge 60 ]; then
    printf '%s' "$YELLOW"
  else
    printf '%s' "$GREEN"
  fi
}

# dec <tenths> <unit> — decimal with trailing .0 trimmed: (43, h) -> "4.3h"
dec() {
  _f=$(( $1 % 10 ))
  if [ "$_f" -eq 0 ]; then
    printf '%d%s' "$(( $1 / 10 ))" "$2"
  else
    printf '%d.%d%s' "$(( $1 / 10 ))" "$_f" "$2"
  fi
}

# duration_str <seconds> — compact duration for countdowns and ages:
#   "X.Yd" (>= 1d) / "X.Yh" (>= 1h) / "Nm", rounded to nearest; ".0" is
#   trimmed ("4h" not "4.0h"). "0m" if <= 0.
duration_str() {
  _secs=$1
  [ "$_secs" -le 0 ] && { printf '0m'; return; }
  if [ "$_secs" -ge 86400 ]; then
    dec "$(( (_secs + 4320) / 8640 ))" d    # tenths of a day, rounded
  elif [ "$_secs" -ge 3600 ]; then
    dec "$(( (_secs + 180) / 360 ))" h      # tenths of an hour, rounded
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
  [ -n "$_resets" ] && _reset=" in $(duration_str $(( _resets - NOW )))"
  printf '%s:%s%s %s%%%s%s' "$_label" "$_pcolor" "$(bar "$_int")" "$_pct" "$RESET" "$_reset"
}

# tokens_str <count> — compact token count: 73612 -> "74k", 1000000 -> "1M"
tokens_str() {
  if [ "$1" -ge 999500 ]; then
    dec "$(( ($1 + 50000) / 100000 ))" M
  else
    printf '%dk' "$(( ($1 + 500) / 1000 ))"
  fi
}

# bar <pct> — 10-cell progress bar, one cell per 10% (rounded): 24 -> "██░░░░░░░░"
bar() {
  _filled=$(( ($1 + 5) / 10 ))
  _i=0
  while [ "$_i" -lt 10 ]; do
    if [ "$_i" -lt "$_filled" ]; then
      printf '█'
    else
      printf '░'
    fi
    _i=$(( _i + 1 ))
  done
}

# context_str — context usage bar, percentage, and token counts
context_str() {
  _ctx=$(printf '%.0f' "$in_ctx")
  _ctx_detail=""
  [ -n "$in_ctx_tokens" ] && [ -n "$in_ctx_size" ] &&
    _ctx_detail=" ($(tokens_str "$in_ctx_tokens")/$(tokens_str "$in_ctx_size"))"
  printf '%s' "Ctx:$(pct_color "$_ctx")$(bar "$_ctx") $_ctx%$RESET$_ctx_detail"
}

# directory_str — working directory and git branch, with home abbreviated
directory_str() {
  [ -n "$in_dir" ] || return 0
  _branch=$(git -C "$in_dir" --no-optional-locks branch --show-current 2>/dev/null) || _branch=""
  case "$in_dir" in
    "$HOME"|"$HOME"/*) _dir="~${in_dir#"$HOME"}" ;;
    *)                 _dir="$in_dir" ;;
  esac
  printf '%s' "$_dir${_branch:+:$_branch}"
}

# cache_str — cache expiry, recache tokens, misses, and last miss cause
cache_str() {
  if [ "$in_c_observed" != true ]; then
    _cache="N/A"
  elif [ "${in_c_exp:-0}" -gt "$NOW" ]; then
    _cache="$GREEN$(duration_str $(( in_c_exp - NOW ))) left$RESET"
  else
    _state=cold
    [ -z "$in_c_exp" ] || _state=expired
    _cache="$YELLOW$_state$RESET${in_c_cold:+ (~$(tokens_str "$in_c_cold") to recache)}"
  fi

  [ -n "$in_c_miss" ] && [ -n "$in_c_req" ] &&
    _cache="$_cache, $in_c_miss/$in_c_req misses"

  _age=$(( NOW - ${in_c_last:-0} ))
  [ -n "$in_c_last" ] && [ "$_age" -ge 0 ] &&
    _cache="$_cache (${in_c_cause:+$in_c_cause, }$(duration_str "$_age") ago)"

  printf 'Cache: %s' "$_cache"
}

# add <segment> — append <segment> to $row with a " | " separator (skip empty)
add() {
  [ -z "$1" ] || row="${row:+$row | }$1"
}

row=""
add "$in_model${in_effort:+ ($in_effort)}"
add "${in_version:+v$in_version}"
add "$(context_str)"
add "$(directory_str)"
line1=$row

row=""
add "$(meter 5h "$in_five" "$in_five_at")"
add "$(meter 7d "$in_week" "$in_week_at")"
add "${in_cost:+$(printf '$%.2f' "$in_cost")}"
add "$(cache_str)"
line2=$row

printf '%s\n%s' "$line1" "$line2"
