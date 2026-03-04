# charmkeeper

A custom agent to simplify the maintenance of your charms.

It will analyze you charms and propose you to take action to bring them to the latest standards.

For each selected area, it will create a corresponding PR.

Current supported areas:

- unit-tests
- integration-tests
- terrafom modules

It can process multiple charms in parallel or look at multiple areas for a single charm in parallel.

## Requirements

To use the agent, create a dedicated virtual machine to isolate it from your main system: it will have its own credentials, and you will be able to run it in autonomous mode.

You can use `multipass` to create a machine:

```bash
sudo snap install multipass
multipass launch 24.04 \
  --name charmkeeper \
  --cpus 4 \
  --memory 8G \
  --disk 50G \
  --timeout 180
```

## Installation and configuration

From this point, all operations are done in the `charmkeeper` virtual machine:

```bash
multipass shell charmkeeper
```

The installation starts with cloning the `charmkeeper` repo:

```bash
git clone https://github.com/seb4stien/charmkeeper.git
```

Then you can use the following helper scripts to configure the virtual machine:

```bash
cd charmkeeper
./scripts/charmkeeper-install-requirements.sh
./scripts/charmkeeper-configure-credentials.sh
```

## Usage

Note: all commands are expected to be run from the `~/charmkeeper` folder in the `charmkeeper` virtual machine.

### Interactive mode

Start the agent with `copilot --agent charmkeeper`.

You can then enter something like this in the prompt "align canonical/netbox-k8s-operator with our terraform standards".

It can also be done directly from the command line;

```bash
copilot --agent charmkeeper -i "align canonical/hockeypuck-k8s-operator with our terraform standards"
```

Note: you can use the `/yolo` command in the copilot console to active the autonomous mode.

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

or

```bash
copilot --agent charmkeeper -i "align all repositories from the canonical org with the 'charm' and 'squad-emea' topics with our terraform standards" --yolo
```

You can ask it to work on multiple topics on the same charm in parallel:

```bash
copilot --agent charmkeeper -i "align canonical/hockeypuck-k8s-operator with our standards" --yolo
```

## Example PRs

- [chore(terraform): align terraform modules (charmkeeper)](https://github.com/canonical/ubuntu-motd-server-operator/pull/31)
- [Migrate unit tests from Harness to Context (charmkeeper)](https://github.com/canonical/smtp-integrator-operator/pull/164)
- [chore(terraform): update terraform and juju provider versions to latest standards](https://github.com/canonical/netbox-k8s-operator/pull/69)
