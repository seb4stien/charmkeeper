#!/bin/bash
# Copyright 2025 Canonical Ltd.
# See LICENSE file for licensing details.

# Installs charmkeeper requirements on the charmkeeper VM

set -euo pipefail

sudo snap install concierge --classic
sudo concierge prepare -c concierge.yaml

uv tool install tox --with tox-uv
uv tool update-shell

# Install GitHub CLI
# See: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
if ! which gh > /dev/null; then
	echo "Installing GitHub CLI"
    (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
fi

# Install Copilot CLI
curl -fsSL https://gh.io/copilot-install | sudo bash