# dotfiles

Dotfiles are laid out for use of gnu stow , with installation and configuration done automatically
by [install.sh](./install.sh). Setup is ideally machine portable but there are some external
dependencies that are left out due to MacOS/Linux differences.

## Required Tools

The following CLI tools are configured and should be installed to make best use of the config:

* stow
* bat
* fd-find
* fzf
* delta


## Recommended Extras

The git configuration is left anonymous for privacy, as it also may change between machines for different
purposes. In order to add customisations, create a file `~/.gitconfig.local` with any extra config and the
gitconfig provided will automatically include it. Examples are commit author, email, ssh keys and agent config.


## Codespaces Setup

A few things are required for an effective codespaces setup, you need a recent ubuntu image as older ones
are incompatible with modern neovim etc. The below devcontainer is known to work and provides a lot of
the tools that are configured here.

```json
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/devcontainers/features/sshd:1": {},
    "ghcr.io/kreemer/features/stow:1": {},
    "ghcr.io/devcontainers/features/node:1": {},
    "ghcr.io/meaningful-ooo/devcontainer-features/fish:1": {},
    "ghcr.io/devcontainers-contrib/features/neovim-homebrew:1": {},
    "ghcr.io/devcontainers-contrib/features/tmux-homebrew:1": {},
    "ghcr.io/devcontainers-contrib/features/fzf:1": {},
    "ghcr.io/devcontainers-contrib/features/fd:1": {}
  }
}
```
