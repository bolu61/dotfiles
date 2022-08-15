#!/bin/sh
set -e
if [ -d "$HOME/dotfiles" ]; then
    DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles"
    mkdir -p "$DATA_DIR"
    rm -rf "$DATA_DIR/backup"
    mv "$HOME/dotfiles" "$DATA_DIR/backup"
fi

git clone --bare https://github.com/bolu61/dotfiles "$HOME/dotfiles"
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
echo "backing up pre-existing dot files"
mkdir -p "$HOME/dotfiles.b"
dotfiles ls-tree --name-only --full-tree -r HEAD | xargs -I% sh -c "[ ! -f $HOME/% ] || mv $HOME/% $HOME/dotfiles.b"
dotfiles checkout
echo "checked out config"
dotfiles config status.showUntrackedFiles no
dotfiles rm "$HOME/install.sh"

