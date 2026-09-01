if type -q systemctl
    if systemctl --user is-active ssh-agent >/dev/null
        set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
    end
end
