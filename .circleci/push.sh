#!/bin/bash

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_ID" --password-stdin

# arg 체크
if [ $# -eq 1 ]; then
  if [ "$1" != "dev" ] && [ "$1" != "prod" ]; then
    echo "Argument는 dev, prod 만 가능합니다."
    exit 0
  elif [ "$1" == "dev" ]; then

    echo "-----DEV 이미지 BUILD AND PUSH-----"
    docker build -t "$DOCKER_REPOSITORY":develop -f ./Dockerfile.dev .
    docker push "$DOCKER_REPOSITORY":develop

  elif [ "$1" == "prod" ]; then

    echo "-----PROD 이미지 BUILD AND PUSH-----"
    docker build \
      -t "$DOCKER_REPOSITORY":"$CIRCLE_SHA1" \
      -t "$DOCKER_REPOSITORY":master \
      -t "$DOCKER_REPOSITORY":latest .
    docker push "$DOCKER_REPOSITORY":"$CIRCLE_SHA1"
    docker push "$DOCKER_REPOSITORY":master
    docker push "$DOCKER_REPOSITORY":latest

  fi
else
  echo "올바른 입력이 아닙니다."
  exit 0
fi