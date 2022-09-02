# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -f "$HOME/.local/dotfiles/.profile" ] ; then
    source "$HOME/.local/dotfiles/.profile"
fi

# set PATH so it includes user's private bin
PATH="$HOME/.local/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

dotfiles () {
    git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" $@
}

export -f dotfiles

# invoke interactive bash
exec bash --noprofile
