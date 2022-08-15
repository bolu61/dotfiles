#!/bin/sh
set -e

BASEDIR=$(dirname "$0")
SOURCE="${SOURCE:-"dirname $0"}"

git clone --bare "$SOURCE" "$HOME/.dotfiles"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo "backing up pre-existing dot files"
dotfiles ls-tree --name-only --full-tree -r HEAD | xargs -I% sh -c "[ ! -f $HOME/% ] || mkdir -p "$HOME/dotfiles.b" && mv -f $HOME/% $HOME/dotfiles.b"
dotfiles checkout
echo "checked out config"
dotfiles config status.showUntrackedFiles no
dotfiles rm "$HOME/install.sh" "$HOME/README.md"
