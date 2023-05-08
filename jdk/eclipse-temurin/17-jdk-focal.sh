#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-17-jdk-focal start'

IMAGE=eclipse-temurin:17-jdk-focal

# 17-jdk-focal
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:17-jdk-focal-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:17-jdk-focal \
    -f ${PROJECT_DIR}/jdk/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache

echo 'build eclipse-temurin-17-jdk-focal finished'
echo " "
echo " "