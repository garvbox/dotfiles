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

These are intentionally not automated for local setups, as they could be on linux or MacOS, so left
to install manually rather than maintaining something complex.

## Fonts

Nerd Fonts are required for most of the tools here. The terminal of the month is generally configured with a font,
the installation instructions vary by platform so are left as a manual step required depending
on where this is being used. Fonts are only required for desktop platforms and are not needed
when only being used as a remote shell.


## Recommended Extras

The git configuration is left anonymous for privacy, as it also may change between machines for different
purposes. In order to add customisations, create a file `~/.gitconfig.local` with any extra config and the
gitconfig provided will automatically include it. Examples are commit author, email, ssh keys and agent config.

