#!/bin/bash

set -e

echo " "
echo " "
echo 'build docker-jdk start'

docker buildx bake \
    -f ${PROJECT_DIR}/jdk/docker-jdk/docker-jdk-bake.hcl \
    --pull \
    --push \
    --no-cache

echo 'build docker-jdk finished'
echo " "
echo " "
