if type -q eza
    abbr -a ls 'eza -lhaF --color=auto --icons=always'
    abbr -a l 'eza -lhaF --color=auto --icons=always'
    abbr -a lt 'eza --tree'
end

abbr -a cr 'cargo run'
abbr -a dc 'docker compose'

if type -q bat
    abbr -a cat bat --no-paging
end

if type -q nvim
    abbr -a vi nvim
    abbr -a vim nvim
end

if type -q zoxide
    abbr -a cd z
end

if type -q systemctl
    abbr -a sysctl systemctl
    abbr -a usysctl "systemctl --user"

    abbr -a jctl journalctl
    abbr -a js "journalctl -xeu"
    abbr -a ujctl "journalctl --user"
    abbr -a ujs "journalctl --user -xeu"
end

abbr -a gst git status
abbr -a gcsm git commit --signoff --message
abbr -a gp git push
abbr -a ga git add
abbr -a gc git clone

if type -q emacs
    abbr -a ed "emacs --daemon"
    abbr -a em "emacsclient -c"
    abbr -a et "emacsclient -nw"
    abbr -a killemacs "emacsclient -e \"(kill-emacs)"\"

    abbr -a ff vterm_cmd find-file .
    abbr -a orgidp git commit --signoff --message ".orgids"

    if type -q systemctl
        if systemctl --user is-active emacs.service
            abbr -a ed "systemctl --user start emacs; journalctl --user -eu emacs --follow"
            abbr -a red "systemctl --user restart emacs; journalctl --user -eu emacs --follow"
            abbr -a killemacs "systemctl --user kill emacs; journalctl --user -eu emacs --follow"
        end
    end
end
