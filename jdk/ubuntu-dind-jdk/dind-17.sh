#!/bin/sh

## check and download with adoptium api
## https://github.com/adoptium/api.adoptium.net/blob/main/docs/cookbook.adoc#example-two-linking-to-the-latest-jdk-or-jre
## https://github.com/adoptium/api.adoptium.net/blob/main/docs/cookbook.adoc#example-three-scripting-a-download-using-the-adoptium-api

set -e

echo " "
echo " "
echo 'build ubuntu-dind-jdk-17 start'

FEATURE_VERSION=17

# 17-ubuntu-dind-jdk
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg FEATURE_VERSION=${FEATURE_VERSION} \
    --push \
    -t ${CI_REGISTRY}/opcal/ubuntu-dind-jdk:17 \
    -f ${PROJECT_DIR}/jdk/ubuntu-dind-jdk/base/Dockerfile . --no-cache

echo 'build ubuntu-dind-jdk-17 finished'
echo " "
echo " "
