# charmkeeper

A custom agent to simplify the maintenance of your charms.

It will analyze your charms and propose changes via draft PR to bring them to the latest standards.

Current supported areas:

- unit-tests: not deeply tested yet
- integration-tests: not deeply tested yet
- terraform modules: used in platform-engineering team.

It can process multiple charms in parallel or look at multiple areas for a single charm in parallel.

## Requirements

To use the agent, create a dedicated virtual machine to isolate it from your main system: it will have its own credentials, and you will be able to run it in autonomous mode.

You can use `multipass` to create a machine:

```bash
sudo snap install multipass
multipass launch 24.04 \
  --name charmkeeper \
  --cpus 8 \
  --memory 16G \
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

All commands are expected to be run from the `~/charmkeeper` folder in the `charmkeeper` virtual machine.

After running the agent, you will find its learning in `learnings/`. You may want to look at it to see if there's something you could better document somewhere. You should privilege things that are not specific to the agent first:

- Should the reference implementation(s) be updated?
- Should the `CONTRIBUTING.md` file be updated?
- Should you reference/update external documentation?

And as a last resort, you may want to update the agent itself.

Once you have take the learnings into account, you can empty the folder.

### Interactive mode

Start the agent with `copilot --agent charmkeeper`.

You can then enter something like this in the prompt "align canonical/netbox-k8s-operator with our terraform standards".

It can also be done directly from the command line:

```bash
copilot --agent charmkeeper -i "align canonical/hockeypuck-k8s-operator with our terraform standards"
```

Note: you can use the `/yolo` command in the copilot console to activate the autonomous mode.

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
copilot --agent charmkeeper -i "align all non-archived repositories from the canonical org with the 'charm' and 'squad-emea' topics with our terraform standards" --yolo
```

You can ask it to work on multiple topics on the same charm in parallel:

```bash
copilot --agent charmkeeper -i "align canonical/hockeypuck-k8s-operator with our standards" --yolo
```

## Example PRs

- Terraform examples: [31](https://github.com/canonical/ubuntu-motd-server-operator/pull/31), [41](https://github.com/canonical/postfix-relay-operators/pull/41), [52](https://github.com/canonical/opendkim-operator/pull/52), [69](https://github.com/canonical/netbox-k8s-operator/pull/69), [75](https://github.com/canonical/ingress-configurator-operator/pull/75), [92](https://github.com/canonical/digest-squid-auth-helper/pull/92), [186](https://github.com/canonical/saml-integrator-operator/pull/186), [111](https://github.com/canonical/falco-operators/pull/111), [114](https://github.com/canonical/opencti-operator/pull/114),[157](https://github.com/canonical/httprequest-lego-provider/pull/157), [168](https://github.com/canonical/smtp-integrator-operator/pull/168), [200](https://github.com/canonical/hockeypuck-k8s-operator/pull/200), [208](https://github.com/canonical/gateway-api-integrator-operator/pull/208), [323](https://github.com/canonical/nginx-ingress-integrator-operator/pull/323), [367](https://github.com/canonical/wazuh-server-operator/pull/367), [385](https://github.com/canonical/haproxy-operator/pull/385), [610](https://github.com/canonical/traefik-k8s-operator/pull/610)
- [Migrate unit tests from Harness to Context (charmkeeper)](https://github.com/canonical/smtp-integrator-operator/pull/164)
- [chore(terraform): update terraform and juju provider versions to latest standards](https://github.com/canonical/netbox-k8s-operator/pull/69)
