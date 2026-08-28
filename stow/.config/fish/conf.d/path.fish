fish_add_path "~/.local/bin"
fish_add_path "~/.config/emacs/bin/"
fish_add_path "~/.cargo/bin/"

if systemctl --user is-enabled ssh-agent
    end

if type -q trash-put
    abbr rm trash-put
end
