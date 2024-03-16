#!/bin/bash
set -e

main() {

	# Codespaces are a fairly specific environment, we can pretty much guarantee that they are
	# running ubuntu and so can install the tools there first
	if [[ -n $CODESPACES ]]; then
		codespace_install_setup
	else
		echo "Running Local Setup"
		download_alacritty_themes
		run_stow_package local
	fi

	# Common setup items for local and codespaces
	run_stow_package common
	install_tpm
	install_starship
	download_fish_themes
}

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

codespace_install_setup() {
	echo "Running Codespaces-Specific setup"
	echo "Setting Fish shell default"
	sudo chsh "$(id -un)" --shell "/usr/bin/fish"
	# Installing fish in codespaces puts some default config in, remove it
	rm -rf $HOME/.config/fish
}

install_tpm() {
	if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
		git clone --quiet https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
		echo "Installed TPM"
	else
		echo "Tmux directory exists, skipped setting up TPM"
	fi
}

install_starship() {
	if ! command_exists starship; then

		echo "Installing Starship"
		curl -sS https://starship.rs/install.sh | sh -s -- -y
	else
		echo "Starship already installed..."
	fi
}

run_stow_package() {
	if ! command_exists stow; then
		echo "ERROR: Missing GNU Stow"
		exit -1
	else
		echo "Running Stow package: $1"
		stow -Sv -t $HOME $1
	fi
}

download_alacritty_themes() {
	alacritty_theme_path="${HOME}/.config/alacritty/themes"
	mkdir -p $alacritty_theme_path
	git clone https://github.com/alacritty/alacritty-theme ${alacritty_theme_path}
}


main

