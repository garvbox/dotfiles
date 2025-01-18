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
		download_delta_themes
		download_bat_themes
	fi

	# Common setup items for local and codespaces
	run_stow_package common
	install_tpm
	install_starship
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
	if [[ ! -d $alacritty_theme_path ]]; then
		echo "Downloading Alacritty themes file"
		mkdir -p $alacritty_theme_path
		git clone https://github.com/alacritty/alacritty-theme ${alacritty_theme_path}
	fi
}

download_delta_themes() {
	delta_theme_path="${HOME}/.local/share/delta"
	if [[ ! -d $delta_theme_path ]]; then
		mkdir -p $delta_theme_path
	fi
	delta_themes_file="${delta_theme_path}/catppuccin.gitconfig"
	if [[ ! -f $delta_themes_file ]]; then
		echo "Downloading Delta themes file"
		wget -q -O ${delta_themes_file} https://raw.githubusercontent.com/catppuccin/delta/main/catppuccin.gitconfig
	else
		echo "Delta themes already downloaded"
	fi
}

download_bat_themes() {
	bat_themes_path="$(bat --config-dir)/themes"

	if [[ ! -d $bat_themes_path ]]; then
		mkdir -p $bat_themes_path
	fi
	echo "Downloading Bat themes"
	wget -q -P ${bat_themes_path} https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
	wget -q -P ${bat_themes_path} https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
	wget -q -P ${bat_themes_path} https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
	wget -q -P ${bat_themes_path} https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
	bat cache --build
}

main

