if [[ "$OSTYPE" == darwin* ]]; then
    local ssh_agent_socket=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    if [[ -S $ssh_agent_socket ]]; then
        export SSH_AUTH_SOCK=$ssh_agent_socket
    fi
elif [[ "$OSTYPE" == linux* && -S ~/.1password/agent.sock ]]; then
    local ssh_agent_socket=~/.1password/agent.sock
    if [[ -S $ssh_agent_socket ]]; then
        export SSH_AUTH_SOCK=$ssh_agent_socket
    fi
fi
