#!/bin/bash
# Copyright 2025 Canonical Ltd.
# See LICENSE file for licensing details.

# Configure user credentials on the charmkeeper VM

set -euo pipefail

echo "Configuring Copilot CLI credentials"
copilot login

echo "Configuring GitHub CLI credentials"
gh auth login

echo "Configure Git credentials"
read -p "Enter your Git user name (recommended: 'Real Name (charmkeeper)'): " git_user
read -p "Enter your Git user email (recommended: 'realmail+charmkeeper@realdomain'): " git_email
git config --global user.name "$git_user"
git config --global user.email "$git_email"

echo "Generating GPG key"
gpg --batch --passphrase '' --quick-generate-key "$git_user <$git_email>" ed25519 default 1y

KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$git_email" | grep '^sec' | awk '{print $2}' | cut -d'/' -f2)

git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true

echo
echo "You can now add the generated GPG key to your GitHub settings: https://github.com/settings/gpg/new"
gpg --export --armor "$KEY_ID"

echo
echo "Note: if you registered a specific email for charmkeeper, make sure to add it as a secondary email in your GitHub account and mark it as verified to ensure the GPG key is correctly associated to your account: https://github.com/settings/emails"