#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-11 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:11-jdk

# jdk-11
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t ${CI_REGISTRY}/opcal/git-jdk:11-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/git-jdk:11 \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache

docker push --all-tags ${CI_REGISTRY}/opcal/git-jdk

docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:11-${TIMESTAMP}
docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:11

echo 'build git-jdk-11 finished'
echo " "
echo " "