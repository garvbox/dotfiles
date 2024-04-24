
# OMZ-Style gbda
# Check for develop and similarly named branches
function git_develop_branch
  command git rev-parse --git-dir &>/dev/null || return
  for branch in dev devel develop development
    if command git show-ref -q --verify refs/heads/$branch
      echo $branch
      return 0
    end
  end

  echo develop
  return 1
end

# Check if main exists and use instead of master
function git_main_branch
  command git rev-parse --git-dir &>/dev/null || return
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}
    if command git show-ref -q --verify $ref
      echo $ref
      return 0
    end
  end

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
end

function gbda
  git branch --no-color --merged \
    | command grep -vE "^([+*]|\s*($git_main_branch|$git_develop_branch)\s*\$)" \
    | command xargs git branch --delete 2>/dev/null
end

