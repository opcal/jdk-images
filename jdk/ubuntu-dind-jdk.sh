#!/bin/sh

set -e

echo " "
echo " "
echo 'build opcal-jdk start'

# ubuntu-dind-jdk
find ${PROJECT_DIR}/jdk/ubuntu-dind-jdk/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

echo 'build opcal-jdk finished'
echo " "
echo " "