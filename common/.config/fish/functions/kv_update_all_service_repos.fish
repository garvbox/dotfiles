function kv_update_all_service_repos -d 'Update the default branch of every Keelvar service repo, preserving checked-out feature branches'
  echo "Updating repos: $KV_SERVICES"

  # Working directory saved to return at end
  set wd $(pwd)
  for service in $(string split ',' $KV_SERVICES)
    echo "################# $service ######################"
    if not cd ~/projects/$service
      continue
    end

    if not command git rev-parse --git-dir >/dev/null 2>&1
      echo "  not a git repo, skipping"
      continue
    end

    set -l default_branch (_kv_default_branch)
    set -l branch (command git symbolic-ref --quiet --short HEAD)

    if not command git fetch --all --prune
      continue
    end

    if test -z "$branch"
      echo "  detached HEAD, fetched only"
      continue
    end

    if test "$branch" = "$default_branch"
      command git pull --ff-only
      continue
    end

    # Fast-forward the default branch via refspec rather than checkout, so a dirty tree is never disturbed
    command git fetch origin $default_branch:$default_branch

    if _kv_branch_is_merged $branch $default_branch
      set -l dirty (command git status --porcelain)
      if test -n "$dirty"
        echo "  $branch is merged but tree is dirty, staying on $branch"
      else
        echo "  $branch is merged, switching to $default_branch"
        command git checkout $default_branch
      end
    else
      echo "  $branch is not merged, left on $branch ($default_branch updated)"
    end
  end
  cd $wd;
end

# git_main_branch resolves refs/heads/main ahead of master, which is wrong for Keelvar repos
function _kv_default_branch
  set -l head (command git symbolic-ref --quiet --short refs/remotes/origin/HEAD)
  if test -n "$head"
    string replace 'origin/' '' $head
    return
  end

  for candidate in master main dev trunk
    if command git show-ref -q --verify refs/remotes/origin/$candidate
      echo $candidate
      return
    end
  end

  echo master
end

function _kv_branch_is_merged -a branch default_branch
  if command git merge-base --is-ancestor HEAD refs/heads/$default_branch 2>/dev/null
    return 0
  end

  # A tracked branch whose remote ref vanished on prune was merged and deleted (covers squash merges)
  set -l upstream (command git config --get branch.$branch.merge)
  set -l remote (command git config --get branch.$branch.remote)
  if test -n "$upstream" -a -n "$remote"
    set -l remote_ref refs/remotes/$remote/(string replace 'refs/heads/' '' $upstream)
    if not command git rev-parse --verify --quiet $remote_ref >/dev/null
      return 0
    end
  end

  return 1
end
