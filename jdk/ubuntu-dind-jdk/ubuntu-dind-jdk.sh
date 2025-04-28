#!/bin/sh

## check and download with adoptium api
## https://github.com/adoptium/api.adoptium.net/blob/main/docs/cookbook.adoc#example-two-linking-to-the-latest-jdk-or-jre
## https://github.com/adoptium/api.adoptium.net/blob/main/docs/cookbook.adoc#example-three-scripting-a-download-using-the-adoptium-api

set -e

echo " "
echo " "
echo 'build ubuntu-dind-jdk start'

echo " "
echo " "

docker buildx bake \
    -f ${PROJECT_DIR}/jdk/ubuntu-dind-jdk/ubuntu-dind-jdk-bake.hcl \
    --pull \
    --push \
    --no-cache

echo 'build ubuntu-dind-jdk finished'
echo " "
echo " "