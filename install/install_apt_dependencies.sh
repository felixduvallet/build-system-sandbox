#!/usr/bin/env bash
# Install only the apt-get vehicle dependencies.

set -e
set -x

sudo apt-get update && \
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
clang \
clang-format \
cmake \
curl \
git \
less \
nano \
zsh