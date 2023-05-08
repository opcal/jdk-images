#!/bin/sh

set -e

echo " "
echo " "
echo 'build openjdk-19-jdk-slim start'

BASE_IMAGE=openjdk:19-jdk-slim

# 19-jdk-slim
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/openjdk:19-jdk-slim-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/openjdk:19-jdk-slim \
    -f ${PROJECT_DIR}/jdk/openjdk/base/Dockerfile . --no-cache

echo 'build openjdk-19-jdk-slim finished'
echo " "
echo " "