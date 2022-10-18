#!/bin/sh

set -e

echo " "
echo " "
echo 'build docker-jdk-11 start'

LATEST=$(curl https://api.github.com/repos/adoptium/temurin11-binaries/releases/latest | grep tag_name | cut -d '"' -f 4)
URL_VERSION=$(curl -s -o /dev/null -w %{url_effective} --get --data-urlencode "${LATEST}" "" | cut -d '?' -f 2)
FILE_VERSION=$(echo $(echo "${LATEST}" | cut -d '-' -f 2) | sed "s/+/_/" )
JDK_URL=https://github.com/adoptium/temurin11-binaries/releases/download/${URL_VERSION}/OpenJDK11U-jdk_x64_alpine-linux_hotspot_${FILE_VERSION}.tar.gz

## https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.15%2B10/OpenJDK11U-jdk_x64_alpine-linux_hotspot_11.0.15_10.tar.gz

# 11-jdk-focal-docker
docker build \
    --build-arg JDK_URL=${JDK_URL} \
    --build-arg LATEST=${LATEST} \
    -t docker-jdk:11-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jdk/docker-jdk/base/Dockerfile . --no-cache
docker image tag docker-jdk:11-${TAG_VERSION} ${CONTAINER_REGISTRY_URL}/opcal/docker-jdk:11
docker push ${CONTAINER_REGISTRY_URL}/opcal/docker-jdk:11

docker rmi -f ${CONTAINER_REGISTRY_URL}/opcal/docker-jdk:11
docker rmi -f docker-jdk:11-${TAG_VERSION}

echo 'build docker-jdk-11 finished'
echo " "
echo " "
