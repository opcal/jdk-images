#!/bin/sh

set -e

echo " "
echo " "
echo 'build opcal-jdk start'

# openjdk
find ${PROJECT_DIR}/jdk/openjdk/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

echo 'build opcal-jdk finished'
echo " "
echo " "