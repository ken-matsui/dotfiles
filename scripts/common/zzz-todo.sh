#!/bin/sh
set -eu

BOLD="$(tput bold)"
ITALIC="$(tput sitm)"
UNDERLINE="$(tput smul)"
RESET="$(tput sgr0)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
CYAN="$(tput setaf 6)"

H1="$BOLD$UNDERLINE$BLUE"
H2="$BOLD$UNDERLINE$CYAN"
CODE="$YELLOW$ITALIC"
KBD="$(tput setab 7)$(tput setaf 0)"

REMINDER="${BOLD}${UNDERLINE}${RED}==> Make sure to do these TODOs! <==${RESET}"

to_h1() {
  echo "$H1### $*$RESET"
}
to_h2() {
  echo "$H2#### $*$RESET"
}
to_code() {
  echo "$CODE\`$*\`$RESET"
}
to_kbd() {
  echo "$KBD$*$RESET"
}

cat <<EOF
$REMINDER

$(to_h1 Both OS)

$(to_h2 1Password)

* Settings -> Developer -> Enable $(to_code Use the SSH agent)
* Settings -> Developer -> Enable $(to_code Integrate with 1Password CLI)

$(to_h1 macOS)

$(to_h2 System Settings)

* System Settings -> trackpad -> Trackpad speed: Fast
* System Settings -> Keyboard -> Keyboard -> Modifier Keys -> Caps Lock Key -> Control
* System Settings -> Dock & Menu Bar -> Spotlight -> Show in Menu Bar -> disable
* System Settings -> Dock & Menu Bar -> Wi-Fi -> Show in Menu Bar -> disable
* System Settings -> Dock & Menu Bar -> Bluetooth -> Show in Menu Bar -> disable
* System Settings -> Dock & Menu Bar -> Battery -> Show Percentage
* System Settings -> Dock & Menu Bar -> Clock -> Show date -> $(to_code always)

$(to_h2 Things 3)

* Settings -> Quick Entry -> Enable shortcut for Quick Entry -> $(to_kbd Cmd) + $(to_kbd Shift) + $(to_kbd T)

$(to_h1 'Manjaro (TODOs)')

* SSH
  * Copy $(to_code public key) in 1Password to $(to_code ~/.ssh/authorized_keys)

* Find trash command
  * https://unix.stackexchange.com/q/42757
  * https://github.com/andreafrancia/trash-cli/
  * https://github.com/nateshmbhat/rm-trash

$(to_h1 'Ubuntu (TODO: migrate to Manjaro)')

$(to_h2 Settings)

* Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Typing -> Switch to next input source -> $(to_kbd Ctrl) + $(to_kbd Space) (automatically applies to $(to_code Switch to previous input source): $(to_kbd Alt) + $(to_kbd Ctrl) + $(to_kbd Space))
* Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Navigation -> Move to workspace on the left -> $(to_kbd Super) + $(to_kbd Left).
* Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Navigation -> Move to workspace on the right -> $(to_kbd Super) + $(to_kbd Right).

$(to_h2 Gnome Tweaks)

* Keyboard & Mouse -> Mouse Click Emulation -> Enable $(to_code Fingers)

$(to_h2 Remap Keys)

* Open $(to_code input-remapper)
* $(to_code Prior) ($(to_code PageUp)) -> $(to_code KEY_LEFT)
* $(to_code Next) ($(to_code PageDown)) -> $(to_code KEY_RIGHT)

$REMINDER
EOF
