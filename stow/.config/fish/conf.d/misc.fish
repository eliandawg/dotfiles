set -U LSP_USE_PLISTS true
set -U fish_key_bindings fish_vi_key_bindings

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
