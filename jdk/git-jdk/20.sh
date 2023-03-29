#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-20 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:20-jdk

# jdk-20
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t git-jdk:20-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache
docker image tag git-jdk:20-${TAG_VERSION} ${CI_REGISTRY}/opcal/git-jdk:20-${TIMESTAMP}
docker image tag git-jdk:20-${TAG_VERSION} ${CI_REGISTRY}/opcal/git-jdk:20

docker push ${CI_REGISTRY}/opcal/git-jdk:20-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/git-jdk:20


docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:20
docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:20-${TIMESTAMP}
docker rmi -f git-jdk:20-${TAG_VERSION}

echo 'build git-jdk-20 finished'
echo " "
echo " "