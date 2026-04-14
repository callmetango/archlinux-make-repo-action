#!/bin/sh

set -e -u

log_group() {
	printf "::group::${1}\n"
}

log_endgroup() {
	printf "::endgroup::\n"
}

HOME=/home/builder
INPUT_REPO_ADD_FLAGS='' #TODO

log_group "Copying files from $GITHUB_WORKSPACE to $HOME/gh-action"
mkdir -p "$HOME"/gh-action
cd "$HOME"/gh-action
log_endgroup

log_group "Running repo_add"
repo_add $INPUT_REPO_ADD_FLAGS $INPUT_REPO_NAME *.pkg.*
log_endgroup

WORKPATH=$GITHUB_WORKSPACE
WORKPATH=${WORKPATH%/}

log_group "Copying files from $HOME/gh-action to $WORKPATH"
sudo cp -fv * "$WORKPATH"
log_endgroup
