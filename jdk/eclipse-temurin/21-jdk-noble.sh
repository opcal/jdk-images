#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-21-jdk-noble start'

IMAGE=eclipse-temurin:21-jdk-noble

# 21-jdk-noble
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:21-jdk-noble-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:21-jdk-noble \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:21-jdk \
    -f ${PROJECT_DIR}/jdk/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache

echo 'build eclipse-temurin-21-jdk-noble finished'
echo " "
echo " "