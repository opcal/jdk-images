#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-17 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:17-jdk

# jdk-17
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/git-jdk:17-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/git-jdk:17 \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache

echo 'build git-jdk-17 finished'
echo " "
echo " "