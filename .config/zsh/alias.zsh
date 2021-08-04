##################################
# Aliases
##################################

alias gigafter='git rm --cached $(git ls-files --full-name -i --exclude-standard)' # After adding .gitignore, ignore files
alias deletedocker='docker ps -aq | xargs docker rm && docker images -aq | xargs docker rmi'
