#!/bin/sh
set -e

SOURCE="${SOURCE:-"."}"

git clone --bare "$SOURCE" "$HOME/.dotfiles"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo "backing up pre-existing dot files"
dotfiles ls-tree --name-only --full-tree -r HEAD | xargs -I% sh -c "[ ! -f $HOME/% ] || mkdir -p "$HOME/dotfiles.b" && mv -f $HOME/% $HOME/dotfiles.b"
dotfiles checkout
echo "checked out config"
dotfiles config status.showUntrackedFiles no
dotfiles rm "$HOME/install.sh" "$HOME/README.md"
