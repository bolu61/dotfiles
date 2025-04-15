function dotfiles() {
	case "$1" in
		cd) cd "$XDG_DATA_HOME/dotfiles";;
		*) "$XDG_DATA_HOME/dotfiles/install.sh" "$@";;
	esac
}
