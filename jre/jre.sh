#!/bin/sh

set -e

echo " "
echo " "
echo 'build opcal-jre start'

# eclipse-temurin
# find ${PROJECT_DIR}/jre/eclipse-temurin -type f -iname '*.sh' | sort -n | xargs -I {} sh {};

${PROJECT_DIR}/jre/eclipse-temurin/jre-alpine.sh

echo 'build opcal-jre finished'
echo " "
echo " "