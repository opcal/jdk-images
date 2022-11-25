#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-11 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:11-jdk

# jdk-11
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t git-jdk:11-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache
docker image tag git-jdk:11-${TAG_VERSION} ${CI_REGISTRY}/opcal/git-jdk:11-${TIMESTAMP}
docker image tag git-jdk:11-${TAG_VERSION} ${CI_REGISTRY}/opcal/git-jdk:11

docker push ${CI_REGISTRY}/opcal/git-jdk:11-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/git-jdk:11


docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:11
docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:11-${TIMESTAMP}
docker rmi -f git-jdk:11-${TAG_VERSION}

echo 'build git-jdk-11 finished'
echo " "
echo " "