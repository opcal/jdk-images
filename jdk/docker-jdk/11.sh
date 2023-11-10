#!/bin/sh

set -e

echo " "
echo " "
echo 'build docker-jdk-11 start'

FEATURE_VERSION=11

API_URL=https://api.adoptium.net/v3/binary/latest/${FEATURE_VERSION}/ga/alpine-linux/x64/jdk/hotspot/normal/eclipse

# 11-docker-jdk
docker build \
    --build-arg JDK_URL=${JDK_URL} \
    --build-arg LATEST=${LATEST} \
    -t ${CI_REGISTRY}/opcal/docker-jdk:11 \
    -f ${PROJECT_DIR}/jdk/docker-jdk/base/Dockerfile . --no-cache

docker push ${CI_REGISTRY}/opcal/docker-jdk:11
docker rmi -f ${CI_REGISTRY}/opcal/docker-jdk:11

echo 'build docker-jdk-11 finished'
echo " "
echo " "
