#!/bin/bash
set -ex

get_zsh_plugin() {
    install_dir=$1
    repo=$2
    if [[ -d $install_dir ]]; then
        echo "Skipping Install - directory exists: ${install_dir}"
    else
        echo "cloning $repo into $install_dir."
        git clone $repo $install_dir
    fi
}

zsh_custom=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
get_zsh_plugin ${zsh_custom}/plugins/zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
get_zsh_plugin ${zsh_custom}/plugins/zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
get_zsh_plugin ${zsh_custom}/themes/powerlevel10k "--depth=1 https://github.com/romkatv/powerlevel10k.git"

if [[ -f $HOME/.zshrc ]]; then
    echo "zshrc already exists, not updating"
else
    echo "Creating zshrc."
    cat .zshrc > $HOME/.zshrc
fi

if [[ -f $HOME/.gitconfig ]]; then
    echo "gitconfig already exists, not updating"
else
    echo "Updating .gitconfig"
    cat .gitconfig > $HOME/.gitconfig
fi

# Pre-Commit Install and configure
echo "Installing Pre-Commit."
pip3 install --user pre-commit
