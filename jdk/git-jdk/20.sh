#!/bin/sh

set -e

echo " "
echo " "
echo 'build git-jdk-20 start'

IMAGE=ghcr.io/opcal/eclipse-temurin:20-jdk

# jdk-20
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t ${CI_REGISTRY}/opcal/git-jdk:20-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/git-jdk:20 \
    -f ${PROJECT_DIR}/jdk/git-jdk/base/Dockerfile . --no-cache

docker push --all-tags ${CI_REGISTRY}/opcal/git-jdk

docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:20-${TIMESTAMP}
docker rmi -f ${CI_REGISTRY}/opcal/git-jdk:20

echo 'build git-jdk-20 finished'
echo " "
echo " "