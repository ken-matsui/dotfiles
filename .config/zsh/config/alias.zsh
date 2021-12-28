##################################
# Aliases
##################################

# https://unix.stackexchange.com/a/81699/37512
alias wanip='\dig @resolver4.opendns.com myip.opendns.com +short' # Get your public IP address
alias wanip4='\dig @resolver4.opendns.com myip.opendns.com +short -4' # Get your public IPv4 address
alias wanip6='\dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6' # Get your public IPv6 address

alias deletedocker='docker ps -aq | xargs docker rm && docker images -aq | xargs docker rmi'
