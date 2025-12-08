function kv_compose_up_all_profiles
  echo "Bringing services up: $COMPOSE_PROFILES"

  for profile in $(string split ',' $COMPOSE_PROFILES)
    echo "################# $profile ######################"
    docker compose --profile $profile up -d --build
  end
end
