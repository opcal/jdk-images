#!/bin/sh

set -e

echo " "
echo " "

#
BASE_IMAGE=ghcr.io/opcal/ubuntu:jammy
JAVA_VERSION=java19
TARGETPLATFORM=linux-amd64
GRAALVM_VERSION=$(curl https://api.github.com/repos/graalvm/graalvm-ce-builds/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -d '-' -f 2)
FIRST_VERSION=$(echo ${GRAALVM_VERSION} | cut -d '.' -f 1)

echo "build graalvm-${JAVA_VERSION}-${FIRST_VERSION} start"

# graalvm-java19
docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg JAVA_VERSION=${JAVA_VERSION} \
    --build-arg TARGETPLATFORM=${TARGETPLATFORM} \
    --build-arg GRAALVM_VERSION=${GRAALVM_VERSION} \
    -t graalvm:${JAVA_VERSION}-${TAG_VERSION} \
    -f ${PROJECT_DIR}/native-vm/graalvm/base/Dockerfile . --no-cache
docker image tag graalvm:${JAVA_VERSION}-${TAG_VERSION} ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${GRAALVM_VERSION}-${TIMESTAMP}
docker image tag graalvm:${JAVA_VERSION}-${TAG_VERSION} ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${FIRST_VERSION}
docker image tag graalvm:${JAVA_VERSION}-${TAG_VERSION} ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${GRAALVM_VERSION}
docker push ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${GRAALVM_VERSION}-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${FIRST_VERSION}
docker push ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${GRAALVM_VERSION}

docker rmi -f ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${GRAALVM_VERSION}
docker rmi -f ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${FIRST_VERSION}
docker rmi -f ${CI_REGISTRY}/opcal/graalvm:${JAVA_VERSION}-${GRAALVM_VERSION}-${TIMESTAMP}
docker rmi -f graalvm:${JAVA_VERSION}-${TAG_VERSION}

echo "build graalvm-${JAVA_VERSION}-${FIRST_VERSION} finished"
echo " "
echo " "