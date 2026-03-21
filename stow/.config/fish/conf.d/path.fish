switch (uname)
    case Darwin
        fish_add_path "/Users/elian/.local/bin"
        fish_add_path "/Users/elian/.config/emacs/bin"

    case Linux
        fish_add_path "/home/elian/.local/bin"
        fish_add_path "/home/elian/.config/emacs/bin/"
        fish_add_path "/home/elian/.cargo/bin/"
end
