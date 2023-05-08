#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-17 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:17-jdk

# jdk-17
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t ${CI_REGISTRY}/opcal/git-jdk:17-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/git-jdk:17 \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache

docker push --all-tags ${CI_REGISTRY}/opcal/git-jdk

docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:17-${TIMESTAMP}
docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:17

echo 'build git-jdk-17 finished'
echo " "
echo " "