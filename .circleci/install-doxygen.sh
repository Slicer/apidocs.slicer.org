#!/bin/bash

DOXYGEN_VERSION=1.8.13
DOXYGEN_SHA256=1b3ceb3708c5099d51341cd4ac63893f05c736388f12fb99958081fc832a3b3e
ARCHIVE_NAME=doxygen-$DOXYGEN_VERSION.linux.bin.tar.gz

cd /usr/src

# Download
if [ ! -f ./${ARCHIVE_NAME} ]; then
  wget --progress=bar:force http://ftp.stack.nl/pub/users/dimitri/${ARCHIVE_NAME}
else
  rm -rf ./doxygen-$DOXYGEN_VERSION
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

pushd doxygen-$DOXYGEN_VERSION

ln -s $(pwd)/bin/doxyindexer /usr/local/bin/doxyindexer
ln -s $(pwd)/bin/doxygen /usr/local/bin/doxygen

popd

