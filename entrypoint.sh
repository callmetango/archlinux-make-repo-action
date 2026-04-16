#!/bin/sh

set -e -u

GL_GROUP_OPEN=0

glgrp() {
	[ $GL_GROUP_OPEN = 1 ] && printf "::endgroup::\n"
	printf "::group::${1}\n"
	GL_GROUP_OPEN=1
}

glgrpend() {
	[ $GL_GROUP_OPEN = 1 ] && printf "::endgroup::\n"
	GL_GROUP_OPEN=0
}

glend() {
	if [ $GL_GROUP_OPEN = 1 ]; then
		printf "::endgroup::\n"
		GL_GROUP_OPEN=0
	fi
}

HOME=/home/runner
WORKPATH="$GITHUB_WORKSPACE/$INPUT_PATH"
WORKPATH="${WORKPATH%/}"

glgrp "Copying files from $WORKPATH to $HOME/work"
mkdir -p "$HOME"/work
cd "$HOME"/work
cp -rfv "$WORKPATH"/* ./

glgrp "Running repo-add"
repo-add "${INPUT_REPONAME}.db${INPUT_COMPRESSION}" *.pkg.*

glgrp "Copying files from $HOME/work to $WORKPATH"
sudo cp -fvu * "$WORKPATH"

glend
