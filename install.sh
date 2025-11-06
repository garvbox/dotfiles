#!/bin/bash
set -e

main() {

	# Codespaces are a fairly specific environment, we can pretty much guarantee that they are
	# running ubuntu and so can install the tools there first
	if [[ -n $CODESPACES ]]; then
		codespace_install_setup
	else
		echo "Running Local Setup"
		download_delta_themes
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
	echo "Setting Zsh shell default"
	sudo chsh "$(id -un)" --shell "/usr/bin/zsh"
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

main

