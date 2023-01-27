#!/bin/sh

set -e

echo " "
echo " "
echo 'build opcal-jdk start'

# eclipse-temurin
find ${PROJECT_DIR}/jdk/eclipse-temurin/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

echo 'build opcal-jdk finished'
echo " "
echo " "