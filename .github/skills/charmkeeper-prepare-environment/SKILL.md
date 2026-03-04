---
name: charmkeeper-prepare-environment
description: Use this skill to prepare the environment for working on a charm.
---

Inform the user that the first installation may take 10 minutes as it will install all the required tools and packages to work on a charm.

Use `scripts/charmkeeper-install-requirements.sh` to install all the required tools and packages to work on a charm.

Then configure the credentials for GitHub and git with the help of the user.

Suggest the user to use a dedicated email and gpg key for charmkeeper to be able to contribute to the charms and sign commits if needed:
```bash
gh auth login -p https -h github.com --web
git config --global user.email "realname+charmkeeper@realdomain"
git config --global user.name "Real Name (charmkeeper)"
```

Ask the user if they want to create gpg key. If yes, create a gpg key with `gpg --full-generate-key` and configure git to use it:
```bash
git config --global user.signingkey <key-id>
git config --global commit.gpgsign true
```

Export the gpg key and invite the user to add it to GitHub:
```bash
gpg --armor --export <key-id>
```

At the end of the process, suggest the user to create a snapshot of their virtual machine to be able to start from a clean base at any time.