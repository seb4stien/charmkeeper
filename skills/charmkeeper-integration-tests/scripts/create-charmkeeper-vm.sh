#!/bin/bash

multipass launch 24.04 \
  --name charmkeeper \
  --cpus 4 \
  --memory 8G \
  --disk 50G \
  --timeout 180

multipass exec charmkeeper -- sudo snap install concierge --classic

multipass exec charmkeeper -- sudo concierge -p k8s prepare --extra-snaps terraform --extra-snaps tflint

multipass exec charmkeeper -- juju bootstrap localhost lxd

multipass exec charmkeeper -- sudo snap install astral-uv --classic

multipass exec charmkeeper -- uv tool install tox --with tox-uv

multipass exec charmkeeper -- uv tool update-shell
