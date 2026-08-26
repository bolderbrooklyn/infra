#!/bin/bash
set -euo pipefail

WORKDIR="$HOME/Projects/Repositories/codeberg.org/bolderbrook/infra"

if [[ "$(uname)" == "Darwin" ]]; then
  # install xcode command line tools
  xcode-select --install || echo "Xcode command line tools are already installed"
fi

git clone https://codeberg.org/bolderbrook/infra.git "$WORKDIR"
cd "$WORKDIR"

if [[ "$(uname)" == "Darwin" ]]; then
  # install lix
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.lix.systems/lix | sh -s -- install

  # install nix-darwin and apply the flake
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#"$(hostname -s)"
fi
