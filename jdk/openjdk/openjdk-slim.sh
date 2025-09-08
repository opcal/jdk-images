#!/bin/sh

set -e

echo " "
echo " "
echo 'build openjdk start'

docker buildx bake \
    -f ${PROJECT_DIR}/jdk/openjdk/openjdk-bake.hcl \
    --pull \
    --push \
    --no-cache

echo 'build openjdk finished'
echo " "
echo " "