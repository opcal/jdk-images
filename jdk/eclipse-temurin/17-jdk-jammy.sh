#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-17-jdk-jammy start'

IMAGE=eclipse-temurin:17-jdk-jammy

# 17-jdk-jammy
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t eclipse-temurin:17-jdk-jammy-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache
docker image tag eclipse-temurin:17-jdk-jammy-${TAG_VERSION} ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:17-jdk-jammy-${TIMESTAMP}
docker image tag eclipse-temurin:17-jdk-jammy-${TAG_VERSION} ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:17-jdk-jammy

docker push ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:17-jdk-jammy-${TIMESTAMP}
docker push ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:17-jdk-jammy

## tag 11-jdk
docker image tag eclipse-temurin:17-jdk-jammy-${TAG_VERSION} ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:17-jdk
docker push ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:17-jdk
docker rmi -f ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:17-jdk
## tag 11-jdk

docker rmi -f ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:17-jdk-jammy
docker rmi -f ${CONTAINER_REGISTRY_URL}/opcal/eclipse-temurin:17-jdk-jammy-${TIMESTAMP}
docker rmi -f eclipse-temurin:17-jdk-jammy-${TAG_VERSION}

echo 'build eclipse-temurin-17-jdk-jammy finished'
echo " "
echo " "