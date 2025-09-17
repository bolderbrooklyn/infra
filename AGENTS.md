# Agent Guidelines for Infrastructure Repository

## Build/Test Commands

- `make build` - Build the Nix configuration without switching
- `make check` - Check configuration (dry-run)
- `make switch` - Apply configuration changes (requires sudo)
- `make update` - Update flake inputs
- `make up` - Update and switch in one command

## Code Style Guidelines

- Language: Nix configuration files
- Formatting: 2-space indentation, no tabs
- Imports: Use relative paths (e.g., `./module.nix`, `../../platforms/common`)
- Structure: Group imports at top, options first, config second
- Comments: Use `#` for single-line, `/* */` for blocks
- Variables: Use camelCase for local variables, kebab-case for option names
- Conditionals: Use `lib.mkIf` for config conditionals
- Default branch: `trunk` (not main/master)

## Error Handling

- Use `lib.mkOption` with proper types and defaults
- Handle platform differences with `pkgs.stdenv.isDarwin`
- Use `lib.mkIf` for conditional configuration

## File Structure

- Host configs: `nix/hosts/<hostname>/`
- Modules: `nix/modules/<name>/default.nix`
- Platform configs: `nix/platforms/<platform>/`

