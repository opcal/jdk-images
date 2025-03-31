#!/bin/sh

set -e

echo " "
echo " "

BASE_IMAGE=ghcr.io/opcal/ubuntu:jammy
JDK_VERSION=21

echo "build graalvm-${JDK_VERSION} start"

# graalvm-java21
docker buildx build \
    --platform ${PLATFORM} \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg JDK_VERSION=${JDK_VERSION} \
    --push \
    -t ${CI_REGISTRY}/opcal/graalvm:${JDK_VERSION} \
    -f ${PROJECT_DIR}/native-vm/graalvm/base/Dockerfile . --no-cache

echo "build graalvm-${JDK_VERSION} finished"
echo " "
echo " "