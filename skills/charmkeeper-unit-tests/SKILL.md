---
name: charmkeeper-tests
description: Use this skill when you need to write, update, migrate or fix unit tests.
---

Plan:

- Find the unit tests in the repository (their could be multiple "tests/unit" folders).
- Ensure each set of unit tests is following the implementation standards.
- Run the tests to ensure the code work as expected.

# Implementation standards

- Unit test should be implemented with `ops.testing`, not `harness`.

- Lint produced code with `tox -e lint`.

# Testing

## Writing unit tests

- Unit test must be implemented with `ops.testing`:

  - See [How to migrate unit tests from Harness](https://documentation.ubuntu.com/ops/latest/howto/legacy/migrate-unit-tests-from-harness/#harness-migration) if the charm is currently using harness.


- For each charm in the repository, there should be a `tests/` folder like: https://github.com/canonical/platform-engineering-charm-template/tree/main/tests

  - Unit tests goes in `tests/unit`
  - Fixtures should look like the ones in https://raw.githubusercontent.com/canonical/haproxy-operator/refs/heads/main/haproxy-operator/tests/unit/conftest.py
  - Helper functions should go in `tests/unit/helper.py`. See an example here: https://raw.githubusercontent.com/canonical/haproxy-operator/refs/heads/main/haproxy-operator/tests/unit/helper.py
  - There is a `tests/unit/test_charm.py` to test the basic behaviors of the charm.
  - There should be additional `tests/unit/test_xxx.py` files to test specific integrations of the charm (see https://github.com/canonical/haproxy-operator/tree/main/haproxy-operator/tests/unit)

## Local testing

The unit tests should be run in a virtual machine named "charmkeeper".

If the machine doesn't exist, create it with: `scripts/create-charmkeeper-vm.sh`.

If not already done, mount the working directory folder in the machine with

```bash
multipass mount --type native $PWD charmkeeper:/workdir
```

Look at CONTRIBUTING.md to see if there are specific instructions to test the charm.

Unless there is something specific mentioned, you should be able to run the tests with:

```bash
multipass exec charmkeeper -d /workdir/ -- tox 
```
