#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-jdk-ubuntu start'

echo " "
echo " "

docker buildx bake \
    -f ${PROJECT_DIR}/jdk/eclipse-temurin/jdk-ubuntu-bake.hcl \
    --pull \
    --push \
    --no-cache

echo 'build eclipse-temurin-jdk-ubuntu finished'
echo " "
echo " "