#!/bin/sh

set -e

echo " "
echo " "
echo 'build opcal-jdk start'

# git-jdk
# find ${PROJECT_DIR}/jdk/git-jdk/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};
${PROJECT_DIR}/jdk/git-jdk/git-jdk.sh

# docker-jdk
find ${PROJECT_DIR}/jdk/docker-jdk/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

# dind-jdk
find ${PROJECT_DIR}/jdk/dind-jdk/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

echo 'build opcal-jdk finished'
echo " "
echo " "