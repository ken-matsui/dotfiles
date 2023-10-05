##################################
# Functions
##################################

alias sizeof='du -sh'

function info() {
  printf '\033[0;34m[INFO]: %s\033[0m\n' "$*"
}
function warn() {
  printf '\033[0;33m[WARNING]: %s\033[0m\n' "$*"
}
function err() {
  printf '\033[0;31m[ERROR]: %s\033[0m\n' "$*"
}
