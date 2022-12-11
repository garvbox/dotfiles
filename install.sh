#!/bin/sh

zshrc() {
    echo "cloning zsh-autosuggestions."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "cloning zsh-syntax-highlighting."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "cloning powerlevel10k."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "import zshrc."
    cat .zshrc > $HOME/.zshrc
}

zshrc

# Pre-Commit Install and configure
echo "Installing Pre-Commit."
pip install pre-commit