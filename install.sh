#!/bin/sh
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
git clone https://github.com/bolu61/dotfiles "$HOME/dotfiles"
dotfiles checkout -f
