#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-11-jdk-focal start'

IMAGE=eclipse-temurin:11-jdk-focal

# 11-jdk-focal
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:11-jdk-focal-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:11-jdk-focal \
    -f ${PROJECT_DIR}/jdk/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache

echo 'build eclipse-temurin-11-jdk-focal finished'
echo " "
echo " "