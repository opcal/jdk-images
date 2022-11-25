#!/bin/sh

set -e

echo " "
echo " "
echo 'build opcal-jdk start'

# openjdk
find ${PROJECT_DIR}/jdk/openjdk/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

# eclipse-temurin
find ${PROJECT_DIR}/jdk/eclipse-temurin/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

# git-jdk
find ${PROJECT_DIR}/jdk/git-jdk/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

# docker-jdk
find ${PROJECT_DIR}/jdk/docker-jdk/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

echo 'build opcal-jdk finished'
echo " "
echo " "