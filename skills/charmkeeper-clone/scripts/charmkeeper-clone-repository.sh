#!/bin/bash

REPO="$1"
BASEDIR="$HOME/tmp/charmkeeper-workdir"

set -euo pipefail

mkdir -p "$BASEDIR"
DEST=$(mktemp -t charmkeeper.XXXX -d --tmpdir="$BASEDIR")

gh repo clone $REPO $DEST

echo "Repo cloned in $DEST"
