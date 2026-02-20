---
name: charmkeeper-terraform
description: Use this skill when asked to write, test or fix terraform modules for a charm.
---

Plan:

- Ensure the terraform modules are following the development standards.
- Run the tests to ensure the modules work as expected.

# Implementation

## Writing terraform modules

All charms should contain terraform tests.

Terraform tests may be found under:

- `terraform/` only

Or

- `terraform/charm/` and `terraform/product/`

Or

- `terraform/' and `terraform-product/`

If there are no such folders in the tested charm. Stop here.

- Terraform modules should use juju provider version "~> 1.0".
- The module should only have a "model_uuid" variable, no "model" variable.
- Lint terraform modules with `terraform fmt --recursive` and `tflint`.

# Testing

## Writing terraform tests

- The `terraform/tests` folder should look like: https://github.com/canonical/platform-engineering-charm-template/tree/main/terraform/tests

  - There is a `setup` folder to configure the model. Follow the example from https://raw.githubusercontent.com/canonical/platform-engineering-charm-template/refs/heads/main/terraform/tests/setup/main.tf
  - There is `main.tftest.hcl` file. Follow the example of https://raw.githubusercontent.com/canonical/platform-engineering-charm-template/refs/heads/main/terraform/tests/main.tftest.hcl
  
    - Especially ensure that there is a renovate directive above each "revision" line.

  - After adapting the tests. There should not be a terraform/tests/main.tf file.



## Local testing

The terraform tests should be run in a virtual machine named "charmkeeper".

If the machine doesn't exist, create it with: `scripts/create-charmkeeper-vm.sh`.

If not already done, mount the working directory folder in the machine with

```bash
multipass mount --type native $PWD charmkeeper:/workdir
```

For each TERRAFORM_MODULE

```bash
multipass exec charmkeeper -d /workdir/$TERRAFORM_MODULE -- terraform init
multipass exec charmkeeper -d /workdir/$TERRAFORM_MODULE -- terraform test
```

And run any additional ".sh" scripts in `$TERRAFORM_MODULE/tests`.

## CI testing

This workflow is the reference to use to implement or update CI tests: https://raw.githubusercontent.com/canonical/platform-engineering-charm-template/refs/heads/main/.github/workflows/test_terraform_modules.yaml

- Adapt the k8s-controller and lxd-controller value depending on the charm type.
- Adapt the paths if the modules are organized differently.

# Maintain

## Configuring renovate

Configure renovate like https://raw.githubusercontent.com/canonical/platform-engineering-charm-template/refs/heads/main/renovate.json to

- Add a charmhub datasource and use it.
- Add a regex custom manager for revisions.
- Set ignorePath to an empty array to not exclude the tests/ folders of terraform.

