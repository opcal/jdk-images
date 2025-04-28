#!/bin/sh

set -e

echo " "
echo " "
echo 'build eclipse-temurin-jre-ubuntu start'

echo " "
echo " "

docker buildx bake \
    -f ${PROJECT_DIR}/jre/eclipse-temurin/jre-ubuntu-bake.hcl \
    --pull \
    --push \
    --no-cache

echo 'build eclipse-temurin-jre-ubuntu finished'
echo " "
echo " "