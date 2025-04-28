#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-jre-alpine start'

export GOSU_VERSION=$(curl https://api.github.com/repos/tianon/gosu/releases/latest | jq | grep tag_name | cut -d '"' -f 4)

echo "BASE_IMAGE=[${BASE_IMAGE}] GOSU_VERSION=[${GOSU_VERSION}]"
echo " "
echo " "

docker buildx bake \
    -f ${PROJECT_DIR}/jre/eclipse-temurin/jre-alpine-bake.hcl \
    --pull \
    --push \
    --no-cache

echo 'build eclipse-temurin-jre-alpine finished'
echo " "
echo " "