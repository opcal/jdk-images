#!/bin/bash

set -e

echo " "
echo " "
echo 'build dind-jdk start'

docker buildx bake \
    -f ${PROJECT_DIR}/jdk/dind-jdk/dind-jdk-bake.hcl \
    --pull \
    --no-cache

echo 'build dind-jdk finished'
echo " "
echo " "
