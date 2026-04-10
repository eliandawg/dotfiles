set shell := ["sh", "-c"]

stow:
    @stow -t ~ stow/ --adopt

get-arch:
    @sudo pacman -S --needed $(<cachy-packages.txt)

get-brew:
    @brew install $(<Brewfile)

get-doomemacs:
    @git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
