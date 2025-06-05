# Always always neovim...
abbr vim "nvim"
abbr v "nvim"
abbr nano "nvim"
abbr ed "nvim"
abbr pyvim "source .venv/bin/activate.fish && nvim"

# Git Abbrevs
abbr g "git"
abbr gco "git checkout"
abbr gcb "git checkout -b"
abbr gfa "git fetch --all --prune"
abbr gca "git commit --verbose --all"
abbr gd "git diff"
abbr gl "git pull"
abbr gp "git push"
abbr gs "git status"
abbr gup "git checkout (git_main_branch) && git fetch --all --prune && git pull"
abbr gfp "git commit --amend --no-edit && git push --force"
abbr lg "lazygit"

# Misc shell tools
abbr k "kubectl"
alias cat "bat --paging=never"
alias less "bat"
alias more "bat"
alias l "eza"
alias ls "eza"
alias grep "rg"
alias find "fd"
alias tree "tree -C -I '__pycache__'"

# Granted
alias assume "source (brew --prefix)/bin/assume.fish"


# Docker Compose (From OMZP::docker-compose Snippet)
abbr dcb "docker-compose build"
abbr dcdn "docker-compose down"
abbr dce "docker-compose exec"
abbr dck "docker-compose kill"
abbr dco "docker-compose"
abbr dcp "docker-compose --profile"
abbr dcps "docker-compose ps"
abbr dcrestart "docker-compose restart"
abbr dcrm "docker-compose rm"
abbr dcstart "docker-compose start"
abbr dcstop "docker-compose stop"
abbr dcup "docker-compose up"
abbr dcupb "docker-compose up --build"
abbr dcupd "docker-compose up -d"
abbr dcupdb "docker-compose up -d --build"
