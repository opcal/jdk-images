#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-21-jre-jammy start'

IMAGE=eclipse-temurin:21-jre-jammy

# 21-jre-jammy
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:21-jre-jammy-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:21-jre-jammy \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:21-jre \
    -f ${PROJECT_DIR}/jre/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache

echo 'build eclipse-temurin-21-jre-jammy finished'
echo " "
echo " "