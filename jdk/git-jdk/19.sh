#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-19 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:19-jdk

# jdk-19
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t git-jdk:19-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache
docker image tag git-jdk:19-${TAG_VERSION} ${CI_REGISTRY}/opcal/git-jdk:19-${TIMESTAMP}
docker image tag git-jdk:19-${TAG_VERSION} ${CI_REGISTRY}/opcal/git-jdk:19

docker push ${CI_REGISTRY}/opcal/git-jdk:19-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/git-jdk:19


docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:19
docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:19-${TIMESTAMP}
docker rmi -f git-jdk:19-${TAG_VERSION}

echo 'build git-jdk-19 finished'
echo " "
echo " "