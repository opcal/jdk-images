#!/bin/sh

## check and download with adoptium api
## https://github.com/adoptium/api.adoptium.net/blob/main/docs/cookbook.adoc#example-two-linking-to-the-latest-jdk-or-jre
## https://github.com/adoptium/api.adoptium.net/blob/main/docs/cookbook.adoc#example-three-scripting-a-download-using-the-adoptium-api

set -e

echo " "
echo " "
echo 'build dind-jdk-21 start'

FEATURE_VERSION=11

API_URL=https://api.adoptium.net/v3/binary/latest/${FEATURE_VERSION}/ga/alpine-linux/x64/jdk/hotspot/normal/eclipse


# 21-dind-jdk
docker build \
    --build-arg API_URL=${API_URL} \
    --build-arg FEATURE_VERSION=${FEATURE_VERSION} \
    -t ${CI_REGISTRY}/opcal/dind-jdk:21 \
    -f ${PROJECT_DIR}/jdk/docker-jdk/base/Dockerfile . --no-cache

docker push ${CI_REGISTRY}/opcal/dind-jdk:21
docker rmi -f ${CI_REGISTRY}/opcal/dind-jdk:21

echo 'build dind-jdk-21 finished'
echo " "
echo " "
