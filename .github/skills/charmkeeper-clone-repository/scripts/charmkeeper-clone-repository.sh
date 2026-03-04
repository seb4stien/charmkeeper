#!/bin/bash

REPO="$1"
TASK="$2"

if [ -z "$REPO" ] || [ -z "$TASK" ]; then
  echo "Usage: $0 <repository> <task>"
  exit 1
fi

BASEDIR="$HOME/charmkeeper/workdir"

set -euo pipefail

DEST="$BASEDIR/$REPO.$TASK"
mkdir -p "$DEST"

gh repo clone $REPO $DEST

echo "Repo cloned in $DEST"
