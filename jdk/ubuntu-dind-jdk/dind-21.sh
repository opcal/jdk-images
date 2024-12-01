#!/bin/sh

## check and download with adoptium api
## https://github.com/adoptium/api.adoptium.net/blob/main/docs/cookbook.adoc#example-two-linking-to-the-latest-jdk-or-jre
## https://github.com/adoptium/api.adoptium.net/blob/main/docs/cookbook.adoc#example-three-scripting-a-download-using-the-adoptium-api

set -e

echo " "
echo " "
echo 'build ubuntu-dind-jdk-21 start'

FEATURE_VERSION=21

# 21-ubuntu-dind-jdk
docker build \
    --build-arg FEATURE_VERSION=${FEATURE_VERSION} \
    -t ${CI_REGISTRY}/opcal/ubuntu-dind-jdk:21 \
    -f ${PROJECT_DIR}/jdk/ubuntu-dind-jdk/base/Dockerfile . --no-cache

docker push ${CI_REGISTRY}/opcal/ubuntu-dind-jdk:21
docker rmi -f ${CI_REGISTRY}/opcal/ubuntu-dind-jdk:21

echo 'build ubuntu-dind-jdk-21 finished'
echo " "
echo " "
