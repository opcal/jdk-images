#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-11-jdk-alpine start'

BASE_IMAGE=eclipse-temurin:11-jdk-alpine
GOSU_VERSION=$(curl https://api.github.com/repos/tianon/gosu/releases/latest >> /dev/null 2>&1 | grep tag_name | cut -d '"' -f 4)

echo "BASE_IMAGE=[${BASE_IMAGE}] GOSU_VERSION=[${GOSU_VERSION}]"
echo " "
echo " "

# 11-jdk-alpine
docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg GOSU_VERSION=${GOSU_VERSION} \
    -t eclipse-temurin:11-jdk-alpine-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/eclipse-temurin/base/alpine/Dockerfile . --no-cache
docker image tag eclipse-temurin:11-jdk-alpine-${TAG_VERSION} ${CI_REGISTRY}/opcal/eclipse-temurin:11-jdk-alpine-${TIMESTAMP}
docker image tag eclipse-temurin:11-jdk-alpine-${TAG_VERSION} ${CI_REGISTRY}/opcal/eclipse-temurin:11-jdk-alpine
docker push ${CI_REGISTRY}/opcal/eclipse-temurin:11-jdk-alpine-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/eclipse-temurin:11-jdk-alpine

docker rmi -f ${CI_REGISTRY}/opcal/eclipse-temurin:11-jdk-alpine
docker rmi -f ${CI_REGISTRY}/opcal/eclipse-temurin:11-jdk-alpine-${TIMESTAMP}
docker rmi -f eclipse-temurin:11-jdk-alpine-${TAG_VERSION}

echo 'build eclipse-temurin-11-jdk-alpine finished'
echo " "
echo " "