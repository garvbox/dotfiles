function kv_update_all_service_repos
  echo "Updating repos: $KV_SERVICES"

  # Working directory saved to return at end
  set wd $(pwd)
  for service in $(string split ',' $KV_SERVICES)
    echo "################# $service ######################"
    cd ~/projects/$service
    command git checkout (git_main_branch) && command git fetch --all --prune && command git pull || break
  end
  cd $wd;
end
