#!/bin/sh

set -e

echo " "
echo " "
echo "build graalvm start"


echo "BASE_IMAGE=[${BASE_IMAGE}] GOSU_VERSION=[${GOSU_VERSION}]"
echo " "
echo " "

docker buildx bake \
    -f ${PROJECT_DIR}/native-vm/graalvm/graalvm-bake.hcl \
    --pull \
    --push \
    --no-cache

echo "build graalvm finished"
echo " "
echo " "