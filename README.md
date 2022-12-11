# dotfiles

## Setup

```bash
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
```

## Unlink

```bash
unlink ~/.zshrc
unlink ~/.gitconfig
```

## dotfiles with GitHub Codespaces

`install.sh` installs zsh plugins, copies over `.zshrc` and `.p10k.zsh`, etc.

Mark `install.sh` as executable: `git add install.sh --chmod=+x`

See [link](https://burkeholland.github.io/posts/codespaces-dotfiles/) for more info
