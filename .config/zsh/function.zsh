##################################
# Functions
##################################

# .gitignore generator
function gi() {
  curl -fsSL https://www.gitignore.io/api/$@ >>! $PWD/.gitignore && echo "added $@ to $PWD/.gitignore"
}

# Replace strings recursively (example: $ replace ./ hey hello)
function replace() {
  find $1 -type f -print0 | xargs -0 sed -i '' -e "s/$2/$3/g"
}

function sizeof() {
  du -sh "$@"
}
