# Project Overview: `infra`

This repository manages the system configuration and dotfiles for Jesse Brooklyn Hannah's machines. It uses **Nix Flakes** for reproducible infrastructure as code across both **NixOS** and **Darwin (macOS)** systems.

## Key Technologies & Architecture

- **Package Manager:** [Lix](https://lix.systems/) (a Nix fork focused on stability and modern features).
- **Core Frameworks:**
  - **Nix-Darwin:** System configuration for macOS hosts (`miraidon`, `comfey`).
  - **NixOS:** System configuration for Linux hosts (`tinkaton`).
  - **Home Manager:** User-level environment and dotfile management.
  - **Agenix:** Secret management using age encryption.
- **Directory Structure:**
  - `nix/common/`: Shared configuration and modules used by all platforms.
  - `nix/darwin/`: macOS-specific configuration and host definitions.
  - `nix/nixos/`: NixOS-specific configuration and host definitions.
  - `nix/common/modules/`: Granular modules for applications like `nvim`, `tmux`, `fish`, etc.
  - `k8s/`: Kubernetes manifests (e.g., `traefik.yml`).

## Building and Running

The project includes a `Makefile` for convenience. Commands automatically detect the host platform and target the appropriate configuration.

### Common Commands

- **Apply configuration (rebuild and switch):**
  ```bash
  make switch
  ```
- **Build configuration (dry run):**
  ```bash
  make build
  ```
- **Update all dependencies (flake inputs + devenv):**
  ```bash
  make up
  ```
- **Update flake inputs only:**
  ```bash
  make update
  ```
- **Initialize the repository:**
  ```bash
  ./bootstrap.sh
  ```

## Development Conventions

- **Host Identification:** Configurations are matched using the system hostname (e.g., `.\#$(HOSTNAME)` in the flake).
- **User:** The default username is `brooklyn`.
- **Modularity:** Configuration is highly modular. New features or applications should be added as modules under `nix/common/modules/` and imported in `nix/common/default.nix`.
- **Shells:** `fish` is the default interactive shell, with `zsh` and `nushell` also configured.
- **Styling:** [Catppuccin](https://catppuccin.com/) is used for consistent system-wide theming.
- **Development Environments:** Integrated with [devenv](https://devenv.sh/) for project-specific development shells.

## Key Files

- `flake.nix`: The main entry point defining inputs, outputs, and system configurations.
- `Makefile`: Convenience wrapper for `nixos-rebuild` and `darwin-rebuild`.
- `nix/common/home.nix`: Core Home Manager configuration shared across hosts.
- `secrets.nix`: Definitions for encrypted secrets managed by Agenix.
- `devenv.nix`: Local development environment configuration.
