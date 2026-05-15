#!/bin/sh

set -e -u

. /github-log.sh

# Constants

HOME=/home/runner
BUILDDIR="$HOME"/work
GH_WORKPATH="$GITHUB_WORKSPACE/$INPUT_PATH"
GH_WORKPATH="${GH_WORKPATH%/}"

# Set up environment

sudo chmod -R 0777 "$GITHUB_WORKSPACE"

# Main

cd "$GH_WORKPATH" || exit

echo "Running repo-add"
repo-add "${INPUT_REPONAME}.db${INPUT_COMPRESSION}" *.pkg.tar \
	*.pkg.tar.{gz,bz2,xz,zst,lzo,lrz,lz4,lz,Z}
