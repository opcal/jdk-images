#!/bin/sh

set -e

echo " "
echo " "
echo 'build opcal-native start'

# GraalVM
find ${PROJECT_DIR}/native-vm/graalvm/ -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

echo 'build opcal-native finished'
echo " "
echo " "