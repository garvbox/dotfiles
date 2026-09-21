function kv_compose_up_all_profiles -d 'Bring up every COMPOSE_PROFILES profile detached, rebuilding images unless --no-build is given'
  argparse no-build -- $argv
  or return

  set -l up_args -d
  if not set -q _flag_no_build
    set -a up_args --build
  end

  echo "Bringing services up: $COMPOSE_PROFILES"

  for profile in $(string split ',' $COMPOSE_PROFILES)
    echo "################# $profile ######################"
    docker compose --profile $profile up $up_args
  end
end
