#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-11-jre-jammy start'

IMAGE=eclipse-temurin:11-jre-jammy

# 11-jre-jammy
docker build \
    --build-arg BASE_IMAGE=${IMAGE} \
    -t eclipse-temurin:11-jre-jammy-${TAG_VERSION} \
    -f ${PROJECT_DIR}/jre/eclipse-temurin/base/ubuntu/Dockerfile . --no-cache
docker image tag eclipse-temurin:11-jre-jammy-${TAG_VERSION} ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-jammy-${TIMESTAMP}
docker image tag eclipse-temurin:11-jre-jammy-${TAG_VERSION} ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-jammy

docker push ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-jammy-${TIMESTAMP}
docker push ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-jammy

## 11-jre
docker image tag eclipse-temurin:11-jre-jammy-${TAG_VERSION} ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre
docker push ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre
docker rmi -f ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre
## 11-jre

docker rmi -f ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-jammy
docker rmi -f ${CI_REGISTRY}/opcal/eclipse-temurin:11-jre-jammy-${TIMESTAMP}
docker rmi -f eclipse-temurin:11-jre-jammy-${TAG_VERSION}

echo 'build eclipse-temurin-11-jre-jammy finished'
echo " "
echo " "