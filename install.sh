#!/bin/bash
set -e

# Dotfiles automated setup, run me to configure This script does allow re-running without breaking things,
# however it might not reconfigure existing setups due to complexity.

# Main Setup block
main() {
	echo "Running dotfiles setup"
	setup_link .gitconfig $HOME/.gitconfig "Git Config"
	setup_link nvim $HOME/.config/nvim "Nvim Home"
	setup_link fd $HOME/.config/fd "Fd Home"

	if command_exists alacritty; then
		alacritty_setup
	else
		echo "Alacritty not installed"
	fi
	if command_exists tmux; then
		tmux_setup
	else
		echo "Tmux not installed"
	fi

	if command_exists bat; then
		bat_setup
	else
		echo "Bat not installed"
	fi
}

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

command_exists() {
	command -v "$1" >/dev/null 2>&1
}


tmux_setup() {
	setup_link .tmux.conf $HOME/.tmux.conf "Tmux Config"
	# Clone TPM for tmux if new tmux env
	if [[ ! -d $HOME/.tmux ]]; then
		git clone --quiet https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
		echo "Installed TPM"
	else
		echo "Tmux directory exists, skipped installing TPM"
	fi
}

# Setup Alacritty if its installed and not already configured
alacritty_setup() {
	if [[ ! -d $HOME/.config/alacritty ]]; then
		mkdir $HOME/.config/alacritty
		curl -LO -s --output-dir $HOME/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
		setup_link .alacritty.toml $HOME/.alacritty.toml "Alacritty Config"
	else
		echo "Alacritty Config already exists, skipped downloading theme"
	fi
}

bat_setup () {
	if [[ ! -d $HOME/.config/bat ]]; then
		mkdir $HOME/.config/bat
		setup_link bat/config $HOME/.config/bat/config "Bat Home"
		wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
		wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
		wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
		wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
		bat cache --build
	else
		echo "Bat Home already exists, skipped setup"
	fi
}


main

