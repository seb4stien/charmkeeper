# charmkeeper

A custom agent to simplify the maintenance of your charm.

It will analyze you charm and propose you to take action to bring it to the latest standards.
For each selected area, it will create a corresponding "charmkeeper/xxx" PR.

Current area supported:

- unit-tests
- integration-tests
- terrafom modules

## Requirements

The agent needs `multipass` to be installed to be able to perform tests in an isolated environment:

```bash
sudo snap install multipass
```

Copilot CLI must be installed. See <https://docs.github.com/fr/copilot/how-tos/copilot-cli/set-up-copilot-cli/install-copilot-cli>.

## Installation

```bash
git clone https://github.com/seb4stien/charmkeeper.git
mkdir -p ~/.copilot/{agents,skills}
echo "Installing agents"
for agent in $PWD/charmkeeper/agents/*; do
    ln -sf $agent ~/.copilot/agents/
done
echo "Installing skills"
for skill in $PWD/charmkeeper/skills/*; do
    ln -sf $skill ~/.copilot/skills/
done
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
