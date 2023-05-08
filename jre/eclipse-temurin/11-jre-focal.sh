#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-11-jre-focal start'

IMAGE=eclipse-temurin:11-jre-focal

# 11-jre-focal
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-focal-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-focal \
    -f ${PROJECT_DIR}/jre/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache

echo 'build eclipse-temurin-11-jre-focal finished'
echo " "
echo " "