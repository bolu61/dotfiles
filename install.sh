#!/bin/sh
set -e

BASEDIR="$(dirname "$0")"
SOURCE="${SOURCE:-$BASEDIR}"

export GIT_DOTFILES_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles/git"

BACKUP_DIR="$HOME/.local/dotfiles/backup"

mkdir -p $DOTFILES

git clone --bare "$SOURCE" "$GIT_DOTFILES_DIR"
git config --global alias.dotfiles '!git --git-dir=$GIT_DOTFILES_DIR --work-tree=$HOME'
git dotfiles config status.showUntrackedFiles no

mkdir -p $BACKUP_DIR;
for file in $(git dotfiles ls-tree --name-only --full-tree -r HEAD); do
  if [ -f $HOME/$file ]; then
    mv -f $HOME/$file $BACKUP_DIR
  fi
done

git dotfiles checkout
echo "checked out config"

rm "$HOME/install.sh" "$HOME/README.md"
