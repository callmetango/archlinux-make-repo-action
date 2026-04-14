#!/bin/sh

set -e -u

log_group() {
	printf "::group::${1}\n"
}

log_endgroup() {
	printf "::endgroup::\n"
}

HOME=/home/builder

log_group "Copying files from $GITHUB_WORKSPACE to $HOME/work"
mkdir -p "$HOME"/work
cd "$HOME"/work
cp -rfv "$GITHUB_WORKSPACE/$INPUT_PATH"/ ./
log_endgroup

log_group "Running repo-add"
pwd
ls -la **
repo-add ./foo.db.tar.xz *.zst
log_endgroup

log_group "Copying files from $HOME/work to $WORKPATH"
WORKPATH=$GITHUB_WORKSPACE/$INPUT_PATH
WORKPATH=${WORKPATH%/}
sudo cp -fvu * "$WORKPATH"
log_endgroup
