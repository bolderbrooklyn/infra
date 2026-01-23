# Agent Guidelines for infra

This repository manages NixOS and nix-darwin system configurations using Nix flakes.
Agents must follow these guidelines strictly to ensure system stability and code consistency.

## 1. Build, Lint, and Validation

### Primary Commands
- **Deploy (Apply Changes)**: `make switch` (or `make`)
  - Builds and activates the configuration. **Caution**: modifies the running system.
- **Test Build**: `make build`
  - Builds the configuration *without* activating.
  - **Required**: Run this before `make switch` to verify the build succeeds.
- **Check Validity**: `make check`
  - Instantiates the system derivation to validate syntax and options.
  - Faster than a full build. Use this to catch syntax errors quickly.
- **Update**: `make update` (update flake.lock) or `make up` (update & switch).

### "Running a Single Test"
This repository does not use traditional unit test runners (like pytest). To test/verify specific changes:

1.  **Validation**: Run `make check`.
2.  **Specific Build**: Build a specific attribute to verify it compiles:
    - NixOS: `nix build .#nixosConfigurations.<host>.config.system.build.toplevel`
    - Darwin: `nix build .#darwinConfigurations.<host>.system`
    - Specific Package: `nix build .#<package-name>`
3.  **REPL Inspection**: Use `nix repl` to inspect values and evaluation results:
    ```bash
    nix repl
    :lf .
    nixosConfigurations.tinkaton.config.programs.git.enable
    ```
4.  **Dry Run**: For `darwin-rebuild` or `nixos-rebuild`, use `--dry-run` to see what would change (though `make build` is usually preferred).

### Linting & Formatting
- **Formatter**: `nixfmt`
- **Command**: `nixfmt -w 100 --indent 2 <file>`
- **Rule**: ALL changed `.nix` files must be formatted before committing.
- **Dev Env**: Use `nix develop` or `direnv` to load `devenv` which provides `nixfmt`.

## 2. Code Style & Conventions

### Imports Organization
Order imports in `default.nix` exactly as follows:
1.  `./hardware-configuration.nix` (NixOS only)
2.  `../../platforms/<platform>` (nixos or darwin)
3.  `../../modules/<category>/<module>` (local modules)
4.  External/Other imports

### Naming
- **Directories**: kebab-case (e.g., `nix/modules/my-service/`).
- **Files**: Prefer `default.nix` for modules.
- **Options/Variables**: camelCase (e.g., `enableFeature`, `userName`).

### Types and Options
- **Must use `lib.mkOption`** for all module options.
- **Explicit Types**: Always specify `type = lib.types.<type>;`.
  - Common: `bool`, `str`, `int`, `path`, `package`, `listOf <type>`, `enum <list>`.
- **Example**:
  ```nix
  options.programs.myTool = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable myTool.";
    };
  };
  ```

### Conditional Logic
- Use `lib.mkIf` to guard configuration:
  ```nix
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.myTool ];
  };
  ```
- **Platform Checks**: Use `pkgs.stdenv.isDarwin` or `pkgs.stdenv.isLinux`.

### Error Handling & Assertions
- Use `assertions` to enforce valid configurations:
  ```nix
  assertions = [
    {
      assertion = cfg.enable -> cfg.configFile != null;
      message = "myTool: configFile is required when enabled.";
    }
  ];
  ```

## 3. Architecture Overview

- **`flake.nix`**: Entry point defining hosts and inputs.
- **`nix/hosts/`**: Machine-specific configurations.
  - `tinkaton`: NixOS
  - `miraidon`: macOS
- **`nix/platforms/`**: Shared configurations (nixos/darwin).
- **`nix/modules/`**: Reusable feature modules (e.g., `syncthing`, `postgresql`).
- **`secrets.nix`**: Agenix public key definitions.

## 4. Secrets Management (Agenix)
- **Do not commit raw secrets.**
- **Editing**: `agenix -e nix/hosts/<host>/secrets/<name>.age`
- **Usage**:
  ```nix
  age.secrets.mySecret.file = ./secrets/mySecret.age;
  ```

## 5. Implementation Strategy for Agents
1.  **Read**: Analyze `flake.nix` and `Makefile`.
2.  **Search**: Use `glob` to find relevant modules.
3.  **Plan**: Check existing patterns and conventions.
4.  **Edit**: Apply changes adhering to Style Guide (types, assertions).
5.  **Format**: Run `nixfmt` on modified files.
6.  **Verify**: Run `make check`.
