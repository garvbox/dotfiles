#!/bin/bash
set -e

main() {

	echo "Running Dotfiles Setup"
	install_dependent_tools
	download_delta_themes
	run_stow_package common
	install_tpm
	install_starship
	download_bat_themes
}

command_exists() {
	command -v "$1" >/dev/null 2>&1
}


install_tpm() {
	if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
		git clone --quiet https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
		echo "Installed TPM"
	else
		echo "Tmux directory exists, skipped setting up TPM"
	fi
}

install_dependent_tools() {
	if ! command_exists brew; then
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	# Assumes homebrew has been installed to get this far
	brew install wget ghostty fish nvim eza zoxide fzf fd bat ripgrep stow git-delta lazygit
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

download_delta_themes() {
	delta_theme_path="${HOME}/.local/share/delta"
	if [[ ! -d $delta_theme_path ]]; then
		mkdir -p $delta_theme_path
	fi
	delta_themes_file="${delta_theme_path}/themes.gitconfig"
	if [[ ! -f $delta_themes_file ]]; then
		echo "Downloading Delta themes file"
		wget -q -O ${delta_themes_file} https://raw.githubusercontent.com/dandavison/delta/main/themes.gitconfig
	else
		echo "Delta themes already downloaded"
	fi
}

download_bat_themes() {
	bat_theme_path="${HOME}/.config/bat/themes"
	if [[ ! -d $bat_theme_path ]]; then
		mkdir -p $bat_theme_path
	fi

	# Tokyonight Themes only
	for theme in day moon night storm; do
		bat_themes_file="${bat_theme_path}/tokyonight_${theme}.tmTheme"
		if [[ ! -f $bat_themes_file ]]; then
			echo "Downloading bat themes file: ${bat_themes_file}"
			wget -q -O ${bat_themes_file} https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_${theme}.tmTheme
		fi
	done
	bat cache --build
}

main

