#!/bin/bash
set -e

main() {
	echo "Installing tools"
	chezmoi_setup
	download_alacritty_themes
	install_tmux_tpm
	bat_setup
}

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

chezmoi_setup() {
	if ! command_exists chezmoi; then
		sh -c "$(curl -fsLS get.chezmoi.io)" -- \
			init --apply git@github.com:$GITHUB_USERNAME/dotfiles.git \
			-b $HOME/.local/bin
	fi
}


install_tmux_tpm() {
	if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
		git clone --quiet https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
		echo "Installed TPM"
	else
		echo "Tmux directory exists, skipped setting up TPM"
	fi
}

download_alacritty_themes() {
	if [[ ! -d $HOME/.config/alacritty ]]; then
		mkdir $HOME/.config/alacritty
		wget -P $HOME/.config/alacritty \
			https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
	else
		echo "Alacritty Config already exists, skipped downloading theme"
	fi
}

bat_setup () {
	if [[ ! -d $HOME/.config/bat/themes ]]; then
		mkdir $HOME/.config/bat
		wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
		if command_exists bat; then
			bat cache --build
		else
			echo "Bat is not installed, cache not updated"
		fi
	else
		echo "Bat Themes already exist, skipped setup"
	fi
}

main

