#!/bin/sh

set -e

echo " "
echo " "
echo 'build openjdk-17-jdk-slim start'

BASE_IMAGE=openjdk:17-jdk-slim

# 17-jdk-slim
docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    -t openjdk:17-jdk-slim-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/openjdk/base/Dockerfile . --no-cache
docker image tag openjdk:17-jdk-slim-${TAG_VERSION} ${CI_REGISTRY}/opcal/openjdk:17-jdk-slim-${TIMESTAMP}
docker image tag openjdk:17-jdk-slim-${TAG_VERSION} ${CI_REGISTRY}/opcal/openjdk:17-jdk-slim
docker push ${CI_REGISTRY}/opcal/openjdk:17-jdk-slim-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/openjdk:17-jdk-slim

docker rmi -f ${CI_REGISTRY}/opcal/openjdk:17-jdk-slim
docker rmi -f ${CI_REGISTRY}/opcal/openjdk:17-jdk-slim-${TIMESTAMP}
docker rmi -f openjdk:17-jdk-slim-${TAG_VERSION}

echo 'build openjdk-17-jdk-slim finished'
echo " "
echo " "