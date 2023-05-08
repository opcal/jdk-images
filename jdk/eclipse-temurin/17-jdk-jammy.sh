#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-17-jdk-jammy start'

IMAGE=eclipse-temurin:17-jdk-jammy

# 17-jdk-jammy
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:17-jdk-jammy-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:17-jdk-jammy \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:17-jdk \
    -f ${PROJECT_DIR}/jdk/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache

echo 'build eclipse-temurin-17-jdk-jammy finished'
echo " "
echo " "