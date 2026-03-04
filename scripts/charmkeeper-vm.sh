#!/bin/bash
# Copyright 2025 Canonical Ltd.
# See LICENSE file for licensing details.

# Creates a virtual machine for charmkeeper to operate

VM="charmkeeper"

set -euo pipefail

multipass launch 24.04 \
  --name $VM \
  --cpus 4 \
  --memory 8G \
  --disk 50G \
  --timeout 180

multipass exec $VM -- sudo snap install concierge --classic

multipass exec $VM -- sudo concierge -p k8s prepare --extra-snaps terraform --extra-snaps tflint

multipass exec $VM -- juju bootstrap localhost lxd

multipass exec $VM -- sudo snap install astral-uv --classic

multipass exec $VM -- uv tool install tox --with tox-uv

multipass exec $VM -- uv tool update-shell

# Install GitHub CLI
# See: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
cat << 'EOF' | multipass exec $VM -- sudo bash
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
EOF

# Install GitHub copilot CLI
curl -fsSL https://gh.io/copilot-install | multipass exec $VM -- sudo bash
