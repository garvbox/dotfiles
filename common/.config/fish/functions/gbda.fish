function __git.current_branch -d "Output git's current branch name"
  begin
    git symbolic-ref HEAD; or \
    git rev-parse --short HEAD; or return
  end 2>/dev/null | sed -e 's|^refs/heads/||'
end

function __git.default_branch -d "Use init.defaultBranch if it's set and exists, otherwise use main if it exists. Falls back to master"
  command git rev-parse --git-dir &>/dev/null; or return
  if set -l default_branch (command git config --get init.defaultBranch)
    and command git show-ref -q --verify refs/heads/{$default_branch}
    echo $default_branch
  else if command git show-ref -q --verify refs/heads/main
    echo main
  else
    echo master
  end
end

function gbda -d "Delete all branches merged in current HEAD, including squashed"
  git branch --merged | \
    # *: current branch, +: current branch on worktree.
    command grep -vE  '^\*|^\+|^\s*(master|main|develop)\s*$' | \
    command xargs -r -n 1 git branch -d

  set -l default_branch (__git.default_branch)
  git for-each-ref refs/heads/ "--format=%(refname:short)" | \
    while read branch
      set -l merge_base (git merge-base $default_branch $branch)
      if string match -q -- '-*' (git cherry $default_branch (git commit-tree (git rev-parse $branch\^{tree}) -p $merge_base -m _))
        git branch -D $branch
      end
    end
end
