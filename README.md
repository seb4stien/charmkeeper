# charmkeeper

A custom agent to simplify the maintenance of your charm.

It will analyze you charm and propose you to take action to bring it to the latest standards.
For each selected area, it will create a corresponding "charmkeeper/xxx" PR.

Current areas supported:

- unit-tests
- integration-tests
- terrafom modules

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

From this point, all operations are done in the `charmkeeper` virtual machine:

```bash
multipass shell charmkeeper
```

As `charmkeeper` will run in the VM, you need to configure your GitHub credentials

```bash

```

## Installation

Reminder: all operations are done in the `charmkeeper` virtual machine (`multipass shell charmkeeper` if necessary).

```bash
git clone https://github.com/seb4stien/charmkeeper.git
cd charmkeeper
```

Note: you can also install the `charmkeeper skills` with `npx skills add seb4stien/charmkeeper -y -g -a github-copilot`.

## Usage

First clone a charm you want to work on and cd into it, then invoke the agent.

### Safe mode

In this mode the agent will prompt you for all actions:

```bash
copilot --agent charmkeeper -i "bring this repo up to our standards"
```

### Yolo mode

In this mode the agent will not prompt you. Use it at your own risk.

```bash
copilot --agent charmkeeper -i "bring this repo up to our standards" --yolo
```

## Example PRs

- [Migrate unit tests from Harness to Context (charmkeeper)](https://github.com/canonical/smtp-integrator-operator/pull/164)
- [(charmkeeper) Update terraform module to standards](https://github.com/canonical/smtp-integrator-operator/pull/165/)
- [(charmkeeper) Migrate integration tests to jubilant](https://github.com/canonical/smtp-integrator-operator/pull/166/)

## Next

- Refine the skills: "run lint tests", "run unit tests", "run integration tests"...
