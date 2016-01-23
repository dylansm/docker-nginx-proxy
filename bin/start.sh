#!/usr/bin/env bash

if [[ ! -n "$DEPLOY_ENV" ]]; then
  DEPLOY_ENV=development
fi

compose_override_file="${DEPLOY_ENV}.yml"
docker_name="proxy"

if [[ -f "${compose_override_file}" ]]; then
  echo "Using docker-compose override file: ${compose_override_file}"
  docker-compose -p "${docker_name}${DEPLOY_ENV}" -f docker-compose.yml -f "$compose_override_file" up -d
else
  docker-compose -p "${docker_name}${DEPLOY_ENV}" up -d
fi

if [[ $DEPLOY_ENV == "development" ]]; then
  # first_host_name=$(cat etc/default.conf | grep "\sserver_name" | awk '{print substr($NF, 1, length($NF)-1)}')
  # if [[ "$first_host_name" == "localhost" ]]; then
    # host_name=`$(docker-machine ip default)`
  # else
    # host_name=$first_host_name
  # fi
  host_name=$(docker-machine ip default)
  open "http://${host_name}.xip.io:32769"
fi
