#!/bin/sh
set -e

BASEDIR=$(dirname "$0")
SOURCE="${SOURCE:-$BASEDIR}"

git clone --bare "$SOURCE" "$HOME/.dotfiles"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles ls-tree --name-only --full-tree -r HEAD | xargs -I% sh -c "[ ! -f $HOME/% ] || mkdir -p "$HOME/dotfiles.b" && mv -f $HOME/% $HOME/dotfiles.b"
echo "backed up pre-existing dot files"
dotfiles checkout
echo "checked out config"
dotfiles config status.showUntrackedFiles no
dotfiles rm "$HOME/install.sh" "$HOME/README.md"
