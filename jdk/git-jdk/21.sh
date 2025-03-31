#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-21 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:21-jdk

# jdk-21
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/git-jdk:21-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/git-jdk:21 \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache

echo 'build git-jdk-21 finished'
echo " "
echo " "