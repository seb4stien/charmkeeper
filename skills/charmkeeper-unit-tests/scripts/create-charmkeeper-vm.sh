#!/bin/bash

VM="charmkeeper"

multipass launch 24.04 \
  --name $VM \
  --cpus 4 \
  --memory 8G \
  --disk 50G \
  --timeout 180

multipass exec $VM -- sudo snap install concierge --classic

multipass exec $VM -- sudo concierge -p k8s prepare --extra-snaps terraform --extra-snaps tflint

multipass exec $VM -- juju bootstrap localhost lxd

multipass exec $VM -- sudo snap install astral-uv --classic

multipass exec $VM -- uv tool install tox --with tox-uv

multipass exec $VM -- uv tool update-shell
