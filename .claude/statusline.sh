#!/bin/sh
# Claude Code status line.
#   Line 1: model (effort), version, directory, branch
#   Line 2: context + rate-limit meters (Ctx, 5h, 7d), +added/-removed, cost, duration
#
# The field variables (model, ctx, five, week, …) are assigned by the `eval` of
# jq output below; shellcheck can't trace that, so silence its false positive:
# shellcheck disable=SC2154
input=$(cat)

# --- ANSI colors (bright variants survive terminal dimming) ---
RESET=$(printf '\033[0m')
C_VER=$(printf '\033[90m')     # gray           — version
C_DIR=$(printf '\033[94m')     # bright blue    — directory
C_BRANCH=$(printf '\033[93m')  # bright yellow  — branch
C_ADD=$(printf '\033[92m')     # bright green   — lines added
C_DEL=$(printf '\033[91m')     # bright red     — lines removed
C_COST=$(printf '\033[96m')    # bright cyan    — cost
C_DUR=$(printf '\033[95m')     # bright magenta — duration
C_SAFE=$(printf '\033[92m')    # bright green   — percentage < 60%
C_WARN=$(printf '\033[93m')    # bright yellow  — percentage >= 60%
C_CRIT=$(printf '\033[91m')    # bright red     — percentage >= 85%

# --- Parse every field in one jq pass; @sh keeps values shell-safe ---
eval "$(printf '%s' "$input" | jq -r '
  {
    model:   (.model.display_name                    // "Unknown"),
    effort:  (.effort.level                          // ""),
    version: (.version                               // ""),
    ctx:     (.context_window.used_percentage        // ""),
    five:    (.rate_limits.five_hour.used_percentage // ""),
    five_at: (.rate_limits.five_hour.resets_at       // ""),
    week:    (.rate_limits.seven_day.used_percentage // ""),
    week_at: (.rate_limits.seven_day.resets_at       // ""),
    dir:     (.workspace.current_dir                 // ""),
    added:   (.cost.total_lines_added                // 0),
    removed: (.cost.total_lines_removed              // 0),
    cost:    (.cost.total_cost_usd                   // ""),
    dur:     (.cost.total_duration_ms                // "")
  } | to_entries[] | "\(.key)=\(.value | tostring | @sh)"
')"

_now=$(date +%s)

# pct_color <pct> — traffic-light color for a usage percentage: green / yellow / red
pct_color() {
  if   [ "$1" -ge 85 ]; then printf '%s' "$C_CRIT"
  elif [ "$1" -ge 60 ]; then printf '%s' "$C_WARN"
  else printf '%s' "$C_SAFE"
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

# format_duration <ms> — two most significant units: "Xd Yh" / "Xh Ym" / "Xm Ys" / "Xs"
format_duration() {
  _s=$(( $1 / 1000 ))
  _d=$(( _s / 86400 )); _h=$(( (_s % 86400) / 3600 ))
  _m=$(( (_s % 3600) / 60 )); _s=$(( _s % 60 ))
  if   [ "$_d" -gt 0 ]; then printf '%dd %dh' "$_d" "$_h"
  elif [ "$_h" -gt 0 ]; then printf '%dh %dm' "$_h" "$_m"
  elif [ "$_m" -gt 0 ]; then printf '%dm %ds' "$_m" "$_s"
  else printf '%ds' "$_s"; fi
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

# seg <color> <value> — returns "<color><value><reset>"; empty when <value> is empty
seg() {
  [ -n "$2" ] && printf '%s' "$1$2$RESET"
}

# add <segment> — append <segment> to $row with a two-space separator (skip empty)
add() {
  [ -n "$1" ] && row="${row:+$row  }$1"
}

# === Line 1: model, version, directory, branch ===
branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
case "$dir" in                                   # abbreviate home to ~ (after git lookup)
  "$HOME")   dir="~" ;;
  "$HOME"/*) dir="~${dir#"$HOME"}" ;;
esac

row=$model
[ -n "$effort" ] && row="$row [$effort]"
add "$(seg "$C_VER"    "${version:+v$version}")"
add "$(seg "$C_DIR"    "$dir")"
add "$(seg "$C_BRANCH" "$branch")"
line1=$row

# === Line 2: context + rate-limit meters (Ctx, 5h, 7d), +added/-removed, cost, duration ===
row=""
add "$(meter Ctx "$ctx"  "")"
add "$(meter 5h  "$five" "$five_at")"
add "$(meter 7d  "$week" "$week_at")"
add "${C_ADD}+${added}${RESET}/${C_DEL}-${removed}${RESET}"
add "$(seg "$C_COST"   "${cost:+$(printf '$%.4f' "$cost")}")"
add "$(seg "$C_DUR"    "${dur:+$(format_duration "$dur")}")"
line2=$row

# --- Emit (second line only when non-empty) ---
output=$line1
[ -n "$line2" ] && output="$output
$line2"
printf '%s' "$output"
