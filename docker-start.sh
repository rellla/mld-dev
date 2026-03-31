#!/bin/sh

if [ ! -f docker-compose.yml ]; then
  echo "docker-compose.yml file missing" >&2
  exit 1
fi

export USER_ID=$(stat -c "%u" docker-compose.yml)
export GROUP_ID=$(stat -c "%g" docker-compose.yml)

if [ $USER_ID = 0 ]; then
  echo "The files in this folder should not owned by root." >&2
  exit 1
fi

docker compose up -d
