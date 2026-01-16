# Agent Guidelines for infra

This is a NixOS/nix-darwin infrastructure repository managing system configurations
for multiple hosts using Nix flakes.

## Quick Reference

- **Default action**: `make` or `make switch` - Deploys configuration changes
- **Test first**: `make build` - Build without activating
- **Validate**: `make check` - Check configuration validity
- **Update deps**: `make update` - Update flake.lock
- **Full update**: `make up` - Update inputs and deploy

## Build Commands

### Primary Commands

- `make build` - Build the system configuration without switching to it
  - Validates configuration and creates a result symlink
  - Use this to test changes before deploying
  - Works on both NixOS and macOS (darwin-rebuild)

- `make switch` - Build AND activate configuration (default target)
  - Requires sudo on NixOS, uses `--sudo` flag on darwin
  - Makes changes live immediately
  - Sets the new configuration as boot default

- `make check` - Check configuration validity only
  - Faster than build, validates syntax and options
  - Use before committing changes

### Update Commands

- `make update` - Update all flake inputs (runs `nix flake update`)
  - Updates flake.lock with latest versions
  - Does not rebuild the system
  
- `make up` - Update inputs and deploy in one command
  - Equivalent to `make update && make switch`

### Host-Specific Builds

The Makefile automatically detects the hostname and builds for that host:
- On NixOS: Uses hostname from `hostname -s`
- On macOS: Uses hostname from `hostname -s`
- Hosts defined: `tinkaton` (NixOS), `Miraidon` (macOS)

## Architecture

### Directory Structure

```
nix/
├── hosts/              # Machine-specific configurations
│   ├── tinkaton/      # NixOS desktop/server
│   │   ├── default.nix
│   │   ├── hardware-configuration.nix
│   │   └── secrets/   # agenix encrypted secrets
│   └── miraidon/      # macOS laptop
│       ├── default.nix
│       └── brew.nix   # Homebrew configuration
├── platforms/         # Platform-specific base configs
│   ├── common/        # Shared across NixOS and Darwin
│   ├── nixos/         # NixOS-specific
│   └── darwin/        # macOS-specific
└── modules/           # Reusable feature modules
    ├── syncthing/
    ├── postgresql/
    ├── alacritty/
    └── ...
```

### Key Files

- `flake.nix` - Main entry point, defines all system configurations
- `flake.lock` - Locked versions of all inputs (auto-generated)
- `secrets.nix` - agenix secret definitions with public keys
- `Makefile` - Convenient rebuild commands

## Code Style

### Formatting

- **Formatter**: `nixfmt` with 100 character width, 2-space indentation
- Format all `.nix` files before committing
- Run: `nixfmt -w 100 --indent 2 file.nix`

### Imports

Group imports logically in this order:
1. Hardware configuration (NixOS only)
2. Platform base (`../../platforms/nixos` or `../../platforms/darwin`)
3. Feature modules from `../../modules/`
4. External modules (home-manager, catppuccin, etc.)

Example:
```nix
{
  imports = [
    ./hardware-configuration.nix
    ../../platforms/nixos
    ../../modules/syncthing
    ../../modules/postgresql
  ];
}
```

### Naming Conventions

- **Module directories**: kebab-case (`nix/modules/my-service/`)
- **Module files**: Always `default.nix` in module directory
- **Options**: camelCase (`config.common.username`, `config.gui.font.size`)
- **Attributes**: camelCase for custom options, follow upstream conventions
- **Variables in let bindings**: camelCase (`let username = ...;`)

### Function Parameters

Use standard parameter pattern with destructuring:
```nix
{
  config,
  lib,
  pkgs,
  ...
}:
```

Order: `config`, `inputs`, `lib`, `pkgs`, then any custom parameters, then `...`

### Options Definition

Use `lib.mkOption` for all configurable options with explicit types:

```nix
options.gui.font = {
  name = lib.mkOption {
    type = lib.types.str;
    default = "Cascadia Code NF";
  };
  
  size = lib.mkOption {
    type = lib.types.int;
    default = 15;
  };
};
```

Common types: `lib.types.str`, `lib.types.int`, `lib.types.bool`, `lib.types.package`,
`lib.types.listOf`, `lib.types.enum`

### Conditional Logic

Use `lib.mkIf` for conditional configuration:
```nix
config = lib.mkIf cfg.enable {
  # configuration here
};
```

### Platform Detection

Use `pkgs.stdenv.isDarwin` to detect macOS:
```nix
let
  useCask = pkgs.stdenv.isDarwin;
in
{
  programs.alacritty.package = lib.mkIf useCask null;
}
```

### Let Bindings

Use `let...in` blocks for local variables:
```nix
let
  username = config.common.username;
  home = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${username}";
in
{
  # use username and home here
}
```

### Comments

- Keep comments minimal - prefer self-documenting code
- Use comments for non-obvious decisions or workarounds
- Document why, not what

### Module Structure

Standard module structure:
```nix
{ config, lib, pkgs, ... }:
let
  cfg = config.programs.myprogram;
in
{
  options.programs.myprogram = {
    # options here
  };
  
  config = lib.mkIf cfg.enable {
    # configuration here
  };
}
```

## Secrets Management

- Uses `agenix` for encrypted secrets
- Public keys defined in `secrets.nix`
- Secrets stored in `nix/hosts/*/secrets/*.age`
- Reference secrets: `age.secrets.secretname.file = ./secrets/secretname.age;`

## Home Manager

- Used for user-level configuration
- Access via: `home-manager.users.${config.common.username}`
- Import home-manager modules in platform or module configs
- Set packages: `home.packages = with pkgs; [ ... ];`

## Testing & Validation

1. **Before committing**: `make check` to validate syntax
2. **Before deploying**: `make build` to test full build
3. **Deploy**: `make switch` to activate changes
4. **No automated tests** - rely on Nix's type system and build validation

## Common Patterns

### Adding a New Module

1. Create `nix/modules/mymodule/default.nix`
2. Import in appropriate platform or host config
3. Follow existing module patterns (see `nix/modules/postgresql/` for simple example)

### Adding a New Host

1. Create `nix/hosts/newhostname/default.nix`
2. Add hardware-configuration.nix (NixOS only)
3. Add to `flake.nix` outputs
4. Import appropriate platform base

### Enabling a Service

Most services follow this pattern:
```nix
services.myservice = {
  enable = true;
  # additional configuration
};
```

## CI/CD

- GitHub Actions workflows in `.github/workflows/`
- Weekly flake update automation (flake.yml)
- Weekly devenv update automation (devenv.yml)
- Dependabot for GitHub Actions updates
