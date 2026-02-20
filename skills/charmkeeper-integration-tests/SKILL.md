---
name: charmkeeper-integration-tests
description: Use this skill when you need to write, update, migrate or fix integration tests.
---

Plan:

- Find the integration tests in the repository (their could be multiple "tests/integration" folders).
- Ensure each set of integration tests is following the implementation standards.
- Run the tests to ensure the code work as expected.

# Implementation standards

- Expected versions:

  - `jubilant`: ~> 1.7

- Lint produced code with `tox -e lint`.

# Testing

## Writing integrations tests

- Integration test must be implemented with `jubilant`:

  - See [How to migrate from pytest-operator to Jubilant](https://documentation.ubuntu.com/jubilant/how-to/migrate-from-pytest-operator/) if the charm is currently using pytest-operator.

- The `tests/integration` folder should look like: https://github.com/canonical/platform-engineering-charm-template/tree/main/tests/integration

  - There is a `conftest.py` with the same options as: https://raw.githubusercontent.com/canonical/platform-engineering-charm-template/refs/heads/main/tests/integration/conftest.py
  - There is a `test_charm.py` to test the basic behaviors of the charm.
  - There should be additional `test_xxx.py` files to test specific integrations of the charm.

- Dependencies

  - The charm used in the integration tests should be deployed using the `latest/edge` channel (or "*track*/edge").
  - An explicit revision should be set to deploy the charm.
  
## Local testing

The integration tests should be run in a virtual machine named "charmkeeper".

If the machine doesn't exist, create it with: `scripts/create-charmkeeper-vm.sh`.

If not already done, mount the working directory folder in the machine with

```bash
multipass mount --type native $PWD charmkeeper:/workdir
```

Run integration tests with:

```bash
multipass exec charmkeeper -d /workdir/$TERRAFORM_MODULE -- tox -e integration
```

# Maintain

## Configuring renovate

Configure renovate like https://raw.githubusercontent.com/canonical/platform-engineering-charm-template/refs/heads/main/renovate.json to

- Add a charmhub datasource and use it.
- Add a regex custom manager for revisions.
- Set ignorePath to an empty array to not exclude the tests/ folders of terraform.

