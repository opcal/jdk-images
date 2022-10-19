#!/bin/sh

set -e

echo " "
echo " "
echo 'build docker-jdk-17 start'

LATEST=$(curl https://api.github.com/repos/adoptium/temurin17-binaries/releases/latest | grep tag_name | cut -d '"' -f 4)
URL_VERSION=$(curl -s -o /dev/null -w %{url_effective} --get --data-urlencode "${LATEST}" "" | cut -d '?' -f 2)
FILE_VERSION=$(echo $(echo "${LATEST}" | cut -d '-' -f 2) | sed "s/+/_/" )
JDK_URL=https://github.com/adoptium/temurin17-binaries/releases/download/${URL_VERSION}/OpenJDK17U-jdk_x64_alpine-linux_hotspot_${FILE_VERSION}.tar.gz

## https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.3%2B7/OpenJDK17U-jdk_x64_alpine-linux_hotspot_17.0.3_7.tar.gz

# 17-jdk-focal-docker
docker build \
    --build-arg JDK_URL=${JDK_URL} \
    --build-arg LATEST=${LATEST} \
    -t docker-jdk:17-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/docker-jdk/base/Dockerfile . --no-cache
docker image tag docker-jdk:17-${TAG_VERSION} ${CI_REGISTRY}/opcal/docker-jdk:17
docker push ${CI_REGISTRY}/opcal/docker-jdk:17

docker rmi -f ${CI_REGISTRY}/opcal/docker-jdk:17
docker rmi -f docker-jdk:17-${TAG_VERSION}

echo 'build docker-jdk-17 finished'
echo " "
echo " "
