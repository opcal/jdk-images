#!/bin/sh

set -e

echo " "
echo " "
echo 'build docker-jdk-20 start'

LATEST=$(curl -s https://api.github.com/repos/adoptium/temurin20-binaries/releases/latest | jq | grep tag_name | cut -d '"' -f 4)
URL_VERSION=$(curl -s -o /dev/null -w %{url_effective} --get --data-urlencode "${LATEST}" "example" | cut -d '?' -f 2)
FILE_VERSION=$(echo $(echo "${LATEST}" | cut -d '-' -f 2) | sed "s/+/_/" )
JDK_URL=https://github.com/adoptium/temurin20-binaries/releases/download/${URL_VERSION}/OpenJDK20U-jdk_x64_alpine-linux_hotspot_${FILE_VERSION}.tar.gz


# 20-docker-jdk
docker build \
    --build-arg JDK_URL=${JDK_URL} \
    --build-arg LATEST=${LATEST} \
    -t ${CI_REGISTRY}/opcal/docker-jdk:20 \
    -f ${PROJECT_DIR}/jdk/docker-jdk/base/Dockerfile . --no-cache

docker push ${CI_REGISTRY}/opcal/docker-jdk:20
docker rmi -f ${CI_REGISTRY}/opcal/docker-jdk:20

echo 'build docker-jdk-20 finished'
echo " "
echo " "
