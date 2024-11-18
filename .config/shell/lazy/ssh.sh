#!/usr/bin/env sh

case "$(uname)" in
    Darwin)
        _ssh_agent_socket="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        ;;
    Linux)
        _ssh_agent_socket="$HOME/.1password/agent.sock"
        ;;
    *)
        echo "Error: $0: unknown platform: $(uname)" >&2
        return 1
        ;;
esac

if [ -S "$_ssh_agent_socket" ]; then
    export SSH_AUTH_SOCK="$_ssh_agent_socket"
fi

unset _ssh_agent_socket
