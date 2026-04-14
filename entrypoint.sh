#!/bin/sh

set -e -u

log_group() {
	printf "::group::${1}\n"
}

log_endgroup() {
	printf "::endgroup::\n"
}

HOME=/home/runner
WORKPATH="$GITHUB_WORKSPACE/$INPUT_PATH"
WORKPATH="${WORKPATH%/}"

log_group "Copying files from $WORKPATH to $HOME/work"
mkdir -p "$HOME"/work
cd "$HOME"/work
cp -rfv "$WORKPATH"/* ./
log_endgroup

log_group "Running repo-add"
repo-add foo.db.tar.gz *.pkg.*
log_endgroup

log_group "Copying files from $HOME/work to $WORKPATH"
sudo cp -fvu * "$WORKPATH"
log_endgroup
