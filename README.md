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

To use the agent, create a dedicated virtual machine to isolate it from your main system: it will have it's own credentials, and you will be able to run it in autonomous mode.

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

Install the main tools (it may take some time, ~10min, you can start the next steps in parallel):

```bash
multipass exec charmkeeper -- snap instal concierge --classic
multipass exec charmkeeper -- sudo concierge -p k8s prepare --extra-snaps astral-uv,terraform,tflint --extra-debs git,gnupg,wget
```

Finally, install and configure copilot:

```bash
multipass exec charmkeeper -- sh -c "curl -fsSL https://gh.io/copilot-install | sudo bash"
multipass exec charmkeeper -- copilot login
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

Then let copilot guide you through the final configuration steps with `cd charmkeeper && copilot -i /charmkeeper-prepare-environment --yolo`.

## Usage

Note: all commands are expected to be run from the `~/charmkeeper` folder in the `charmkeeper` virtual machine.

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
