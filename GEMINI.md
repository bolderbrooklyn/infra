# Gemini Code Assistant Context

## Project Overview

This repository contains the personal machine configurations and dotfiles for the
user. It is a monorepo that uses the [Nix](https://nixos.org/) ecosystem to
manage configurations for multiple machines running both NixOS and macOS.

The project is structured to be highly modular, with configurations broken down
into reusable components that are then applied to specific hosts. This allows for
a high degree of consistency and reproducibility across different machines.

### Key Technologies

- **[Nix](https://nixos.org/):** A powerful package manager and build system that
  is used to declaratively manage the entire system configuration.
- **[Nix Flakes](https://nixos.wiki/wiki/Flakes):** A new feature in Nix that
  improves reproducibility and composability by providing a standard way to manage
  dependencies and package Nix expressions.
- **[nix-darwin](https://github.com/LnL7/nix-darwin):** A project that allows you
  to manage your macOS configuration using Nix.
- **[home-manager](https://github.com/nix-community/home-manager):** A tool that
  allows you to manage your user-specific configuration (dotfiles) with Nix.
- **[devenv](https://devenv.sh/):** A tool for creating reproducible developer
  environments with Nix.

### Architecture

The repository is structured as follows:

- `flake.nix`: The entry point for the Nix build. It defines the inputs
  (dependencies) and outputs (configurations) for the project.
- `nix/`: This directory contains all of the Nix code for the project.
  - `hosts/`: Contains the top-level configurations for each machine. Each host
    has its own directory that defines the specific configuration for that machine.
  - `modules/`: Contains reusable modules that can be imported into the host
    configurations. Each module is responsible for configuring a specific piece
    of software or functionality.
  - `platforms/`: Contains platform-specific configurations for NixOS and macOS.
    These files define the base configuration for each platform and are imported
    into the host configurations.
- `Makefile`: Provides a set of convenient commands for building, testing, and
  applying the configurations.
- `devenv.nix`: Defines the development environment for the project.

## Building and Running

The project uses a `Makefile` to provide a consistent interface for building and
managing the configurations. The following commands are available:

- `make switch`: Applies the configuration to the current machine. This is the
  default command.
- `make build`: Builds the configuration without applying it.
- `make check`: Checks the configuration for errors.
- `make update`: Updates all of the flake inputs (dependencies).
- `make up`: A convenience command that runs `make update` and then `make switch`.

The `Makefile` is designed to be run on any of the managed machines. It will
automatically detect the operating system and use the appropriate command
(`nixos-rebuild` or `darwin-rebuild`) to apply the configuration.

## Development Conventions

- **Modularity:** Configurations are broken down into small, reusable modules
  that are then composed to create the final configuration for each host.
- **Declarative Configuration:** The entire system configuration is defined
  declaratively in Nix expressions. This makes the configuration reproducible
  and easy to reason about.
- **Cross-Platform Support:** The repository is structured to support both NixOS
  and macOS from a single codebase.
