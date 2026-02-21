# charmkeeper

An agent to simplify the maintenance of your charm.

It will:

- Look at bringing your charm up to our standards regarding: unit-tests, integration-tests and terraform modules.
- Create a draft PR for area that requires action.

## Install

- Copy the `agents/charmkeeper.md` file to your `~/.copilot/agents` folder.
- Install the `charmkeeper skills` with `npx skills add seb4stien/charmkeeper -y -g`.

Note: the agent needs `multipass` to be installed to be able to perform tests in an isolated environment.

## Usage

### Interactive usage

In this mode the agent will prompt you for all actions:

```bash
copilot --agent charmkeeper -i "bring this repo up to our standards"
```

### Yolo mode

In this mode the agent will not prompt you. You at your own risk.

```bash
copilot --agent charmkeeper -i "bring this repo up to our standards" --yolo
```
