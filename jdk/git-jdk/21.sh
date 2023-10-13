#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-21 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:21-jdk

# jdk-21
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t ${CI_REGISTRY}/opcal/git-jdk:21-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/git-jdk:21 \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache

docker push --all-tags ${CI_REGISTRY}/opcal/git-jdk

docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:21-${TIMESTAMP}
docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:21

echo 'build git-jdk-21 finished'
echo " "
echo " "