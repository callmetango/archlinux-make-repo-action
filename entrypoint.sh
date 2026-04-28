#!/bin/sh

set -e -u

. /github-log.sh

# constants
BUILDDIR="$HOME"/work
GH_WORKPATH="$GITHUB_WORKSPACE/$INPUT_PATH"
GH_WORKPATH="${GH_WORKPATH%/}"

# main

glgrp "Copying files from $GH_WORKPATH to $BUILDDIR"
mkdir -p "$BUILDDIR"
cd "$BUILDDIR"
cp -rfv "$GH_WORKPATH"/* ./

glgrp "Running repo-add"
repo-add "${INPUT_REPONAME}.db${INPUT_COMPRESSION}" *.pkg.*

glgrp "Copying files from $HOME/work to $GH_WORKPATH"
sudo cp -fvu * "$GH_WORKPATH"

glend
