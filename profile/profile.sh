# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# Set PATH so it includes user's private bin.
export PATH="$HOME/.local/bin:$PATH"

# Define XDG directories.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

for f in "$XDG_DATA_HOME/profile"/*.sh; do
  source $f
done
