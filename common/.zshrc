if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -d "$HOME/.local/bin" ]] then
  export PATH="$HOME/.local/bin:$PATH"
fi

# This is added to .profile but not automatically sourced with an ssh shell, so adding here.
# The script does not add a duplicate to the PATH so its safe to source twice
if [[ -f "$HOME/.cargo/env" ]] then
  source "$HOME/.cargo/env"
fi

# Install zinit if needed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::docker-compose
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
# emacs-style line end jumps
bindkey '^E' end-of-line
bindkey '^A' beginning-of-line

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Tweak word selection for slashes
WORDCHARS='*?_.[]~=&;!#$%^(){}<>'

# Aliases
alias vim="nvim"
alias cat="bat"
alias ls="exa"
alias k="kubectl"
alias gup="git checkout $(git_main_branch) && git fetch --all --prune && git pull"
alias dcp="docker-compose --profile"
# Go a little crazy with the tools...
alias cat="bat --paging=never"
alias less="bat"
alias more="bat"
alias l="eza"
alias ls="eza"
alias grep="rg"
alias find="fd"
# Trim the fat from tree outputs
alias tree="tree -C -I '__pycache__'"

# Shell integrations
eval "$(zoxide init --cmd cd zsh)"

# Fire up the starship
eval "$(starship init zsh)"
