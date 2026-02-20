#!/bin/bash

VM="charmkeeper-unit"

multipass launch 24.04 \
  --name $VM \
  --cpus 2 \
  --memory 4G \
  --disk 10G \
  --timeout 180

multipass exec $VM -- sudo snap install astral-uv --classic

multipass exec $VM -- uv tool install tox --with tox-uv

multipass exec $VM -- uv tool update-shell
