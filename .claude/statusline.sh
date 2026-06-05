#!/bin/sh
# Claude Code status line.
#   Line 1: model (effort), version, directory, branch, +added/-removed, cost, duration
#   Line 2: context + rate-limit meters (Ctx, 5h, 7d)
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
C_CTX=$(printf '\033[96m')     # bright cyan    — Ctx label
C_5H=$(printf '\033[95m')      # bright magenta — 5h label
C_7D=$(printf '\033[92m')      # bright green   — 7d label
C_WARN=$(printf '\033[93m')    # bright yellow  — meter fill >= 60%
C_CRIT=$(printf '\033[91m')    # bright red     — meter fill >= 85%

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
    added:   (.cost.total_lines_added                // ""),
    removed: (.cost.total_lines_removed              // ""),
    cost:    (.cost.total_cost_usd                   // ""),
    dur:     (.cost.total_duration_ms                // "")
  } | to_entries[] | "\(.key)=\(.value | tostring | @sh)"
')"

_now=$(date +%s)

# repeat <str> <count> — <str> repeated <count> times
repeat() {
  _out=""; _n=$2
  while [ "$_n" -gt 0 ]; do _out="${_out}$1"; _n=$(( _n - 1 )); done
  printf '%s' "$_out"
}

# bar_color <pct> — fill color for a usage percentage (empty = default)
bar_color() {
  if   [ "$1" -ge 85 ]; then printf '%s' "$C_CRIT"
  elif [ "$1" -ge 60 ]; then printf '%s' "$C_WARN"
  fi
}

# build_bar <pct> <width> <fill> <empty> <color> — only filled glyphs get <color>
build_bar() {
  _pct=$1; _width=$2; _fill=$3; _empty=$4; _color=$5
  _filled=$(( _pct * _width / 100 ))
  [ "$_filled" -gt "$_width" ] && _filled=$_width    # clamp when pct > 100
  _fill_str=$(repeat "$_fill" "$_filled")
  _empty_str=$(repeat "$_empty" $(( _width - _filled )))
  if [ -n "$_color" ] && [ "$_filled" -gt 0 ]; then
    printf '%s' "${_color}${_fill_str}${RESET}${_empty_str}"
  else
    printf '%s' "${_fill_str}${_empty_str}"
  fi
}

# duration_str <epoch> — "(in Xd Yh)"/"(in Xh Ym)" until <epoch>; "(in 0m)" if past
duration_str() {
  _secs=$(( $1 - _now ))
  [ "$_secs" -le 0 ] && { printf '(in 0m)'; return; }
  _d=$(( _secs / 86400 )); _h=$(( (_secs % 86400) / 3600 )); _m=$(( (_secs % 3600) / 60 ))
  if [ "$_d" -ge 1 ]; then printf '(in %dd %dh)' "$_d" "$_h"
  else printf '(in %dh %dm)' "$_h" "$_m"; fi
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

# meter <label> <color> <width> <fill> <empty> <pct> <resets_at>
#   Returns "Label:[bar] NN% (in ...)" — empty when <pct> is empty.
meter() {
  _label=$1; _color=$2; _width=$3; _fill=$4; _empty=$5; _raw=$6; _resets=$7
  [ -n "$_raw" ] || return 0
  _int=$(printf '%.0f' "$_raw")
  _bar=$(build_bar "$_int" "$_width" "$_fill" "$_empty" "$(bar_color "$_int")")
  _reset=""
  [ -n "$_resets" ] && _reset=" $(duration_str "$_resets")"
  printf '%s%s%s:[%s] %s%%%s' "$_color" "$_label" "$RESET" "$_bar" "$_int" "$_reset"
}

# seg <color> <value> — returns "<color><value><reset>"; empty when <value> is empty
seg() {
  [ -n "$2" ] && printf '%s' "$1$2$RESET"
}

# add <segment> — append <segment> to $row with a two-space separator (skip empty)
add() {
  [ -n "$1" ] && row="${row:+$row  }$1"
}

# === Line 1: model, version, directory, branch, cost, duration ===
branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
case "$dir" in                                   # abbreviate home to ~ (after git lookup)
  "$HOME")   dir="~" ;;
  "$HOME"/*) dir="~${dir#"$HOME"}" ;;
esac

row=$model
[ -n "$effort" ] && row="$row ($effort)"
add "$(seg "$C_VER"    "${version:+v$version}")"
add "$(seg "$C_DIR"    "$dir")"
add "$(seg "$C_BRANCH" "$branch")"
add "${C_ADD}+${added:-0}${RESET}/${C_DEL}-${removed:-0}${RESET}"
add "$(seg "$C_COST"   "${cost:+$(printf '$%.4f' "$cost")}")"
add "$(seg "$C_DUR"    "${dur:+$(format_duration "$dur")}")"
line1=$row

# === Line 2: context + rate-limit meters ===
row=""
add "$(meter Ctx "$C_CTX" 10 "█" "░" "$ctx"  "")"
add "$(meter 5h  "$C_5H"   8 "▓" "▒" "$five" "$five_at")"
add "$(meter 7d  "$C_7D"   8 "▓" "▒" "$week" "$week_at")"
line2=$row

# --- Emit (second line only when there are meters to show) ---
output=$line1
[ -n "$line2" ] && output="$output
$line2"
printf '%s' "$output"
