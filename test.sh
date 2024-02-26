#!/usr/bin/env bash

eval "$(micromamba shell hook --shell bash)"

set -eux

# This works
tmp_prefix=$(mktemp -d)/env
root_prefix=$(mktemp -d)/root
export MAMBA_ROOT_PREFIX=$root_prefix


echo "SSL Verify true"
micromamba info

micromamba create -y -p $tmp_prefix
micromamba install -vvv --ssl-verify true -y --dry-run -p $tmp_prefix xtensor -c conda-forge

# This fails
tmp_prefix=$(mktemp -d)/env
root_prefix=$(mktemp -d)/root
export MAMBA_ROOT_PREFIX=$root_prefix

echo "SSL Verify false"
micromamba info

micromamba create -y -p $tmp_prefix
micromamba install -vvv --ssl-verify false -y --dry-run -p $tmp_prefix xtensor -c conda-forge