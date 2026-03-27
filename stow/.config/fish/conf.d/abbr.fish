if type -q eza
  abbr -a ls 'eza -lhaF --color=auto --icons=always'
  abbr -a l 'eza -lhaF --color=auto --icons=always'
  abbr -a lt 'eza --tree'
end

abbr -a cr 'cargo run'
abbr -a dc 'docker compose'

if type -q nvim
    abbr -a vi 'nvim'
    abbr -a vim 'nvim'
end

if type -q zoxide
    abbr -a cd z
end

abbr -a gst git status
abbr -a gcsm git commit --signoff --message
abbr -a gp git push
abbr -a ga git add
abbr -a gc git clone

if type -q emacsclient
    abbr -a em "emacsclient -c"
    abbr -a et "emacsclient -nw"

    abbr -a killemacs "emacsclient -e \"(kill-emacs)"\"
    abbr -a ed "emacs --daemon"

    abbr -a ff vterm_cmd find-file .

    abbr -a orgidp git commit --signoff --message ".orgids"
end

function upgrade --description "Performs updates on a system."
    echo "===============UPDATING PACKAGES==============="
    if type -q pacman
        if type -q paru
            paru -Syu
        else
            pacman -Syu --noconfirm
        end

    else if type -q dnf
        dnf upgrade
    else if type -q apt
        apt update
        apt upgrade -y
    else if type -q brew
        brew upgrade
    end

    if type -q flatpak
        echo "===============UPDATING FLATPAKS==============="
        flatpak upgrade -y
    end

    if type -q doom
        echo "===============UPDATING DOOM EMACS==============="
        doom upgrade
    end
end
