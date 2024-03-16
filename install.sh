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
	download_bat_themes
}

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

codespace_install_setup() {
	echo "Running Codespaces-Specific setup"
	echo "Setting Fish shell default"
	sudo chsh "$(id -un)" --shell "/usr/bin/fish"
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
	if [[ ! -d $HOME/.config/alacritty ]]; then
		mkdir $HOME/.config/alacritty
	fi
	for theme in latte frappe macchiato mocha; do
		theme_file="catppuccin-${theme}.toml"
		if [[ ! -f $HOME/.config/alacritty/${theme_file} ]]; then
			wget -q -P $HOME/.config/alacritty \
				https://github.com/catppuccin/alacritty/raw/main/${theme_file}
		fi
	done
}

download_bat_themes () {
	if [[ ! -d $HOME/.config/bat/themes ]]; then
		mkdir -p $HOME/.config/bat
		for theme in Mocha Latte Frappe Macchiato; do
			cp_theme_file="Catppuccin ${theme}.tmTheme"
			cp_theme_dl="Catppuccin%20${theme}.tmTheme"
			if [[ ! -f ${bat_theme_path}/${cp_theme_file} ]]; then
				wget -q -P "$HOME/.config/bat/themes" \
					https://github.com/catppuccin/bat/raw/main/themes/${cp_theme_dl}
			fi
		done
		if command_exists bat; then
			bat cache --build
		else
			echo "Bat is not installed, cache not updated"
		fi
	fi
}

main

