#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk start'

docker buildx bake \
    -f ${PROJECT_DIR}/jdk/git-jdk/git-jdk-bake.hcl \
    --pull \
    --push \
    --no-cache

echo 'build git-jdk finished'
echo " "
echo " "