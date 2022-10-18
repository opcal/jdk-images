#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-11-jdk-focal start'

IMAGE=eclipse-temurin:11-jdk-focal

# 11-jdk-focal
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t eclipse-temurin:11-jdk-focal-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache
docker image tag eclipse-temurin:11-jdk-focal-${TAG_VERSION} ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jdk-focal-${TIMESTAMP}
docker image tag eclipse-temurin:11-jdk-focal-${TAG_VERSION} ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jdk-focal
docker push ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jdk-focal-${TIMESTAMP}
docker push ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jdk-focal

docker rmi -f ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jdk-focal
docker rmi -f ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jdk-focal-${TIMESTAMP}
docker rmi -f eclipse-temurin:11-jdk-focal-${TAG_VERSION}

echo 'build eclipse-temurin-11-jdk-focal finished'
echo " "
echo " "