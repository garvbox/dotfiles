
# Git Abbrevs
abbr -a gco "git checkout"
abbr -a gcb "git checkout -b"
abbr -a gfa "git fetch --all --prune"
abbr -a gca "git commit --verbose --all"
abbr -a gd "git diff"
abbr -a gl "git pull"
abbr -a gp "git push"
abbr -a gst "git status"
abbr -a gup "git checkout master && git fetch --all --prune && git pull"
abbr -a gfp "git commit --amend --no-edit && git push --force"

# Misc
alias vim="nvim"
abbr -a k "kubectl"
# Granted
alias assume="source (brew --prefix)/bin/assume.fish"

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
