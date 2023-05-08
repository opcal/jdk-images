#!/bin/sh

set -e

echo " "
echo " "

BASE_IMAGE=ghcr.io/opcal/ubuntu:jammy
JAVA_VERSION=java11
GRAALVM_VERSION=$(curl https://api.github.com/repos/graalvm/graalvm-ce-builds/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -d '-' -f 2)
FIRST_VERSION=$(echo ${GRAALVM_VERSION} | cut -d '.' -f 1)

echo "build graalvm-${JAVA_VERSION}-${FIRST_VERSION} start"

# graalvm-java11
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg JAVA_VERSION=${JAVA_VERSION} \
    --build-arg GRAALVM_VERSION=${GRAALVM_VERSION} \
    --push \
    -t ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${GRAALVM_VERSION}-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${FIRST_VERSION} \
    -t ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${GRAALVM_VERSION} \
    -f ${PROJECT_DIR}/native-vm/graalvm/base/Dockerfile . --no-cache

echo "build graalvm-${JAVA_VERSION}-${FIRST_VERSION} finished"
echo " "
echo " "