#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-11-jre-focal start'

IMAGE=eclipse-temurin:11-jre-focal

# 11-jre-focal
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t eclipse-temurin:11-jre-focal-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jre/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache
docker image tag eclipse-temurin:11-jre-focal-${TAG_VERSION} ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jre-focal-${TIMESTAMP}
docker image tag eclipse-temurin:11-jre-focal-${TAG_VERSION} ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jre-focal
docker push ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jre-focal-${TIMESTAMP}
docker push ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jre-focal

docker rmi -f ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jre-focal
docker rmi -f ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:11-jre-focal-${TIMESTAMP}
docker rmi -f eclipse-temurin:11-jre-focal-${TAG_VERSION}

echo 'build eclipse-temurin-11-jre-focal finished'
echo " "
echo " "