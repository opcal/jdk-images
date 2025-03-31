#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-11 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:11-jdk

# jdk-11
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/git-jdk:11-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/git-jdk:11 \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache

echo 'build git-jdk-11 finished'
echo " "
echo " "