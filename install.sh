#!/bin/bash
set -e

main() {
	echo "Installing tools"
	chezmoi_setup
	download_alacritty_themes
	install_tmux_tpm
	bat_setup

	# Codespaces are a fairly specific environment, we can pretty much guarantee that they are 
	if [[ -n $CODESPACES ]]; then
		echo "Running Codespace-Specific Setup"
	fi
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
	fi
	for theme in latte frappe macchiato mocha; do
		theme_file="catppuccin-${theme}.toml"
		if [[ ! -f $HOME/.config/alacritty/${theme_file} ]]; then
			wget -P $HOME/.config/alacritty \
				https://github.com/catppuccin/alacritty/raw/main/${theme_file}
		fi
	done
}

bat_setup () {
	if [[ ! -d $HOME/.config/bat/themes ]]; then
		mkdir -p $HOME/.config/bat
		for theme in Mocha Latte Frappe Macchiato; do
			cp_theme_file="Catppuccin ${theme}.tmTheme"
			cp_theme_dl="Catppuccin%20${theme}.tmTheme"
			if [[ ! -f ${bat_theme_path}/${cp_theme_file} ]]; then
				wget -P "$HOME/.config/bat/themes" https://github.com/catppuccin/bat/raw/main/themes/${cp_theme_dl}
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

