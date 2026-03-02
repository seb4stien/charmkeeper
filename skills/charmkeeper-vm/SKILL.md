---
name: charmkeeper-vm
description: Use this skill to provision a virtual machine named "charmkeeper" to run tests.
---

If the machine doesn't exist, create it with: `scripts/create-charmkeeper-vm.sh`.

If not already done, mount the working directory folder in the machine with

```bash
multipass mount --type native $PWD charmkeeper:/workdir
```
