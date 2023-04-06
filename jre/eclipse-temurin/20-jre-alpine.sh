#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-20-jre-alpine start'

BASE_IMAGE=eclipse-temurin:20-jre-alpine
GOSU_VERSION=$(curl https://api.github.com/repos/tianon/gosu/releases/latest | grep tag_name | cut -d '"' -f 4)

echo "BASE_IMAGE=[${BASE_IMAGE}] GOSU_VERSION=[${GOSU_VERSION}]"
echo " "
echo " "

# 20-jre-alpine
docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg GOSU_VERSION=${GOSU_VERSION} \
    -t eclipse-temurin:20-jre-alpine-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jre/eclipse-temurin/base/alpine/Dockerfile . --no-cache
docker image tag eclipse-temurin:20-jre-alpine-${TAG_VERSION} ${CI_REGISTRY}/opcal/eclipse-temurin:20-jre-alpine-${TIMESTAMP}
docker image tag eclipse-temurin:20-jre-alpine-${TAG_VERSION} ${CI_REGISTRY}/opcal/eclipse-temurin:20-jre-alpine
docker push ${CI_REGISTRY}/opcal/eclipse-temurin:20-jre-alpine-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/eclipse-temurin:20-jre-alpine

docker rmi -f ${CI_REGISTRY}/opcal/eclipse-temurin:20-jre-alpine
docker rmi -f ${CI_REGISTRY}/opcal/eclipse-temurin:20-jre-alpine-${TIMESTAMP}
docker rmi -f eclipse-temurin:20-jre-alpine-${TAG_VERSION}

echo 'build eclipse-temurin-20-jre-alpine finished'
echo " "
echo " "