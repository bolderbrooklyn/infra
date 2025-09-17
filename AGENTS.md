# Agent Guidelines for infra

## Build Commands
- **Build**: `make build` - Build the system configuration
- **Deploy**: `make switch` - Deploy configuration changes (default target)
- **Check**: `make check` - Check configuration validity
- **Update**: `make update` - Update flake inputs
- **Full Update**: `make up` - Update inputs and deploy

## Code Style
- **Language**: Nix expressions for system configuration
- **Formatting**: Use `nixfmt-rfc-style` for consistent formatting
- **Imports**: Group by type - system modules first, then local modules
- **Naming**: Use kebab-case for module names, camelCase for options
- **Structure**: Follow existing module patterns in `nix/modules/`
- **Comments**: Minimal comments, prefer self-documenting code
- **Attributes**: Use `lib.mkOption` for configurable options with proper types

## Architecture
- **Hosts**: Machine-specific configs in `nix/hosts/`
- **Modules**: Reusable components in `nix/modules/`
- **Platforms**: Common configs in `nix/platforms/`
- **Flake**: All dependencies managed through `flake.nix`

## Testing
- No automated tests - validate with `make check` before deploying
- Test changes with `make build` first, then `make switch`