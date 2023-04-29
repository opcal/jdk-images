#!/bin/sh

set -e

echo " "
echo " "
echo 'build openjdk-19-jdk-slim start'

BASE_IMAGE=openjdk:19-jdk-slim

# 19-jdk-slim
docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    -t openjdk:19-jdk-slim-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/openjdk/base/Dockerfile . --no-cache
docker image tag openjdk:19-jdk-slim-${TAG_VERSION} ${CI_REGISTRY}/opcal/openjdk:19-jdk-slim-${TIMESTAMP}
docker image tag openjdk:19-jdk-slim-${TAG_VERSION} ${CI_REGISTRY}/opcal/openjdk:19-jdk-slim
docker push ${CI_REGISTRY}/opcal/openjdk:19-jdk-slim-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/openjdk:19-jdk-slim

docker rmi -f ${CI_REGISTRY}/opcal/openjdk:19-jdk-slim
docker rmi -f ${CI_REGISTRY}/opcal/openjdk:19-jdk-slim-${TIMESTAMP}
docker rmi -f openjdk:19-jdk-slim-${TAG_VERSION}

echo 'build openjdk-19-jdk-slim finished'
echo " "
echo " "