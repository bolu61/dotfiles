#!/bin/sh
set -e

SOURCE="${SOURCE:-$(dirname "$0")}"

DOTFILES=$HOME/.dotfiles
LOCAL=$HOME/.local/dotfiles

git clone --bare "$SOURCE" "$DOTFILES"
alias dotfiles='/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

mkdir -p $LOCAL;
dotfiles ls-tree --name-only --full-tree -r HEAD | xargs -I% sh -c "[ ! -f $HOME/% ] || mv -f $HOME/% $LOCAL"

dotfiles checkout
echo "checked out config"

dotfiles rm "$HOME/install.sh" "$HOME/README.md"
