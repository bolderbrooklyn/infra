#!/bin/bash

# install xcode command line tools
xcode-select --install

# install homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# install lix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.lix.systems/lix | sh -s -- install

# install nix-darwin and apply the flake
nix run nix-darwin/master#darwin-rebuild -- switch --flake .$(hostname -s)
