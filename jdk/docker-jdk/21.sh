#!/bin/sh

set -e

echo " "
echo " "
echo 'build docker-jdk-21 start'

FEATURE_VERSION=21

API_URL=https://api.adoptium.net/v3/binary/latest/${FEATURE_VERSION}/ga/alpine-linux/x64/jdk/hotspot/normal/eclipse

# 21-docker-jdk
docker build \
    --build-arg JDK_URL=${JDK_URL} \
    --build-arg LATEST=${LATEST} \
    -t ${CI_REGISTRY}/opcal/docker-jdk:21 \
    -f ${PROJECT_DIR}/jdk/docker-jdk/base/Dockerfile . --no-cache

docker push ${CI_REGISTRY}/opcal/docker-jdk:21
docker rmi -f ${CI_REGISTRY}/opcal/docker-jdk:21

echo 'build docker-jdk-21 finished'
echo " "
echo " "
