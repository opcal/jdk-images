#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-21-jre-alpine start'

BASE_IMAGE=eclipse-temurin:21-jre-alpine
GOSU_VERSION=$(curl https://api.github.com/repos/tianon/gosu/releases/latest | jq | grep tag_name | cut -d '"' -f 4)

echo "BASE_IMAGE=[${BASE_IMAGE}] GOSU_VERSION=[${GOSU_VERSION}]"
echo " "
echo " "

# 21-jre-alpine
docker buildx build \
    --platform linux/amd64 \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg GOSU_VERSION=${GOSU_VERSION} \
    --push \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:21-jre-alpine-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:21-jre-alpine \
    -f ${PROJECT_DIR}/jre/eclipse-temurin/base/alpine/Dockerfile . --no-cache

echo 'build eclipse-temurin-21-jre-alpine finished'
echo " "
echo " "