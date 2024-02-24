#!/bin/bash
set -e

# Dotfiles automated setup, run me to configure This script does allow re-running without breaking things,
# however it might not reconfigure existing setups due to complexity.

setup_link() {
	src=$PWD/$1
	dst=$2
	if [[ ! -e $dst ]]; then
		ln -s $src $dst
		echo "Linked $3"
	else
		echo "$3 already exists, leaving in place"
	fi
}

setup_link .gitconfig $HOME/.gitconfig "Git Config"
setup_link nvim $HOME/.config/nvim "Nvim Home"
setup_link .tmux.conf $HOME/.tmux.conf "Tmux Config"


# Clone TPM for tmux if new tmux env
if [[ ! -d $HOME/.tmux ]]; then
	git clone --quiet https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
	echo "Installed TPM"
else
	echo "Tmux directory exists, skipped installing TPM"
fi
