#!/bin/bash

set -euo pipefail

DOXYGEN_VERSION=1_8_14
DOXYGEN_VERSION_DOT=$(echo $DOXYGEN_VERSION | sed -e "s/_/./g")
DOXYGEN_SHA256=17d08eadd4016077f0be513394870583801e3c5dfe9caf65fef331f7f4539330
DIRECTORY_NAME=doxygen-${DOXYGEN_VERSION_DOT}.centos7.bin
ARCHIVE_NAME=${DIRECTORY_NAME}.tar.gz

#cd /usr/src
mkdir -p /tmp/test
cd /tmp/test

# Download
rm -rf ./${DIRECTORY_NAME}
if [ ! -f ./${ARCHIVE_NAME} ]; then
  curl -#LO https://github.com/jcfr/doxygen/releases/download/Release_${DOXYGEN_VERSION}/${ARCHIVE_NAME}  
fi

# Verify
sha256_doxygen=`sha256sum ./${ARCHIVE_NAME} | awk '{ print $1 }'`
if [ "$sha256_doxygen" != "$DOXYGEN_SHA256" ]
then
  echo "SHA256 mismatch. Problem downloading Doxygen."
  echo "  current [$sha256_doxygen]"
  echo "  expected[$DOXYGEN_SHA256]"
  exit 1
fi

# Extract
tar -xzvf ${ARCHIVE_NAME}

pushd ${DIRECTORY_NAME}

ln -s $(pwd)/bin/doxyindexer /usr/local/bin/doxyindexer
ln -s $(pwd)/bin/doxygen /usr/local/bin/doxygen

popd

