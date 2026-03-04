# charmkeeper

A custom agent to simplify the maintenance of your charm.

It will analyze you charm and propose you to take action to bring it to the latest standards.

For each selected area, it will create a corresponding PR.

Current areas supported:

- unit-tests
- integration-tests
- terrafom modules

It can process multiple charms in parallel or look at multiple areas for a single charm in parallel.

## Requirements

The recommended way to use the agent is to create a dedicated virtual machine with all the requirements installed for the agent to perform its work.

The `scripts/charmkeeper-vm.sh` script will create a usable VM using multipass. You will need to install `multipass` before using it:

```bash
sudo snap install multipass
```

Then:

```bash
./scripts/charmkeeper-vm.sh
```

Log in the virtual machine (`multipass shell charmkeeper`) and configure you credentials:

```bash
gh auth login -p https -h github.com --web
copilot login
git config --global user.email "you+charmkeeper@example.com"
git config --global user.name "Your Name (charmkeeper)"
```

If you need signed commits, you can create one key for charmkeeper to be able to contribute to your charms: <https://github.com/canonical/platform-engineering-contributing-guide/blob/main/development-setup.md#signed-commits>

At this point, you may want to create a snapshot of your VM if you want to start from a clean base at some point:

```bash
multipass stop charmkeeper
multipass snapshot charmkeeper --name base
```

## Installation

From this point, all operations are done in the `charmkeeper` virtual machine:

```bash
multipass shell charmkeeper
```

The installation is just about cloning the repo:

```bash
git clone https://github.com/seb4stien/charmkeeper.git
cd charmkeeper
```

## Usage

### Interactive mode

Start the agent with `copilot --agent charmkeeper`.

You can then enter something like this in the prompt "align canonical/netbox-k8s-operator with our terraform standards".

It can also be done directly from the command line;

```bash
copilot --agent charmkeeper -i "align canonical/hockeypuck-k8s-operator with our terraform standards"
```

### Yolo mode

In this mode the agent will not prompt you to execute commands, to access URLs or to access specific paths. Use it at your own risk.

```bash
copilot --agent charmkeeper -i "align canonical/opendkim-operator with our terraform standards" --yolo
```

### Batch mode

As the agent will have to wait for the CI to complete, you may ask it to work on multiple charms in parallel:

```bash
copilot --agent charmkeeper -i "align canonical/hockeypuck-k8s-operator canonical/netbox-k8s-operator canonical/ubuntu-motd-server-operator with our terraform standards" --yolo
```

Or you can ask it to work on multiple topics on the same charm in parallel:

```bash
copilot --agent charmkeeper -i "align canonical/hockeypuck-k8s-operator with our standards" --yolo
```

## Example PRs

- [chore(terraform): align terraform modules (charmkeeper)](https://github.com/canonical/ubuntu-motd-server-operator/pull/31)
- [Migrate unit tests from Harness to Context (charmkeeper)](https://github.com/canonical/smtp-integrator-operator/pull/164)
- [chore(terraform): update terraform and juju provider versions to latest standards](https://github.com/canonical/netbox-k8s-operator/pull/69)
