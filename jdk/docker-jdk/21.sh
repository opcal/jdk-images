#!/bin/sh

set -e

echo " "
echo " "
echo 'build docker-jdk-21 start'

LATEST=$(curl 'https://api.adoptium.net/v3/info/release_versions?architecture=x64&heap_size=normal&image_type=jdk&jvm_impl=hotspot&lts=true&os=alpine-linux&page=0&page_size=1&project=jdk&release_type=ga&semver=false&sort_method=DEFAULT&sort_order=DESC&vendor=eclipse&version=%5B21%2C22%29' | jq '.versions[0].openjdk_version' | cut -d '"' -f 2)

FEATURE_VERSION=21

API_URL=https://api.adoptium.net/v3/binary/latest/${FEATURE_VERSION}/ga/alpine-linux/x64/jdk/hotspot/normal/eclipse

# 21-docker-jdk
docker build \
    --build-arg API_URL=${API_URL} \
    --build-arg LATEST=${LATEST} \
    -t ${CI_REGISTRY}/opcal/docker-jdk:21 \
    -f ${PROJECT_DIR}/jdk/docker-jdk/base/Dockerfile . --no-cache

docker push ${CI_REGISTRY}/opcal/docker-jdk:21
docker rmi -f ${CI_REGISTRY}/opcal/docker-jdk:21

echo 'build docker-jdk-21 finished'
echo " "
echo " "
