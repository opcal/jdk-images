#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-17 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:17-jdk

# jdk-17
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t git-jdk:17-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache
docker image tag git-jdk:17-${TAG_VERSION} ${CI_REGISTRY}/opcal/git-jdk:17-${TIMESTAMP}
docker image tag git-jdk:17-${TAG_VERSION} ${CI_REGISTRY}/opcal/git-jdk:17

docker push ${CI_REGISTRY}/opcal/git-jdk:17-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/git-jdk:17


docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:17
docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:17-${TIMESTAMP}
docker rmi -f git-jdk:17-${TAG_VERSION}

echo 'build git-jdk-17 finished'
echo " "
echo " "