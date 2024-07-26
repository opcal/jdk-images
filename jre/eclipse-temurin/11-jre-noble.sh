#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-11-jre-noble start'

IMAGE=eclipse-temurin:11-jre-noble

# 11-jre-noble
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${IMAGE} \
    --push \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-noble-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-noble \
    -t ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre \
    -f ${PROJECT_DIR}/jre/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache

echo 'build eclipse-temurin-11-jre-noble finished'
echo " "
echo " "