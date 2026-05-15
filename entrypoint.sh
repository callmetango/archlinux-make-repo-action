#!/bin/sh

set -e -u

. /github-log.sh

# Constants

HOME=/home/runner
BUILDDIR="$HOME"/work
GH_WORKPATH="$GITHUB_WORKSPACE/$INPUT_PATH"
GH_WORKPATH="${GH_WORKPATH%/}"
REPO_FILENAME="${INPUT_REPONAME}.db${INPUT_COMPRESSION}"

# Set up environment

sudo chmod -R 0777 "$GITHUB_WORKSPACE"

# Main

cd "$GH_WORKPATH" || exit

echo "Running repo-add"
find . ! -name '*.sig' -name '*.pkg.tar*' -exec \
    sh -c "repo-add $REPO_FILENAME \"\$@\"" sh {} +
