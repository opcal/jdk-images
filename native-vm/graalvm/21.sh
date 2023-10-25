#!/bin/sh

set -e

echo " "
echo " "

BASE_IMAGE=ghcr.io/opcal/ubuntu:jammy
JAVA_VERSION=21.0.1
JDK_VERSION=$(echo ${JAVA_VERSION} | cut -d '.' -f 1)

echo "build graalvm-${JAVA_VERSION} start"

# graalvm-java21
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg JAVA_VERSION=${JAVA_VERSION} \
    --build-arg JDK_VERSION=${JDK_VERSION} \
    --push \
    -t ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${TIMESTAMP} \
    -t ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION} \
    -t ${CI_REGISTRY}/opcal/graalvm:${JDK_VERSION} \
    -f ${PROJECT_DIR}/native-vm/graalvm/base/Dockerfile . --no-cache

echo "build graalvm-${JAVA_VERSION} finished"
echo " "
echo " "