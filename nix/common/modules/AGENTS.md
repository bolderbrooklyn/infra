# `nix/common/modules/` — Cross-Platform Shared Modules

Cross-platform tools and applications that affect **both** NixOS and nix-darwin
hosts. Every module here is imported globally by `nix/common/default.nix` and
exposes a `brooklyn.programs.<name>.enable` toggle. Hosts opt in or out via
the toggle — no per-host module imports, no commented imports.

> For **home-manager-only** programs (`bat`, `git`, `fish`, `fd`, `nvim`, …),
> see [`nix/home-manager/AGENTS.md`](../../home-manager/AGENTS.md). Those modules
> do not live here.

The default for each toggle reflects whether the tool is useful for every host
in the grouping: `true` for lightweight universal tools, `false` for heavyweight
or niche ones (alternative shells, agent CLIs, SDKs).

---

## Module Inventory

| Module | Option Path | Default | Notes |
| --- | --- | --- | --- |
| `1password` | `brooklyn.programs._1password.enable` | `false` | Uses `isDarwin` special arg; SSH agent socket path differs per platform. `nix/darwin/default.nix` sets `lib.mkDefault true` so every darwin host gets it. |
| `fish` | `brooklyn.programs.fish.enable` | `true` | Always-on; `programs.fish.defaultShell = true` (set in `nix/common/default.nix`) makes it the default shell |
| `nushell` | `brooklyn.programs.nushell.enable` | `false` | Adds nushell to `environment.systemPackages` and `environment.shells` |
| `openssh` | `brooklyn.programs.openssh.enable` | `true` | Adds `services.openssh.extraConfig` (`PasswordAuthentication no`, `PermitRootLogin no`) |
| `powershell` | `brooklyn.programs.powershell.enable` | `false` | `extraConfig` sub-option lets other modules (`brew`, `starship`) inject shellenv into PowerShell config |
| `xonsh` | `brooklyn.programs.xonsh.enable` | `false` | Adds xonsh to `environment.systemPackages` and `environment.shells` |
| `zsh` | `brooklyn.programs.zsh.enable` | `true` | Zsh shell (enabled, not default) |

> The earlier AGENTS.md listed `buku`, `docker`, `gcloud-cli`, `gnupg`,
> `kubectl`, `mise`, and `yazi` here, but those modules live in
> `nix/home-manager/modules/programs/` — see [home-manager/AGENTS.md](../../home-manager/AGENTS.md).

---

## Module Template

```nix
{ config, lib, pkgs, ... }:
{
  options.brooklyn.programs.<name>.enable = lib.mkEnableOption "<name>";

  config = lib.mkIf config.brooklyn.programs.<name>.enable {
    home-manager.users.${config.common.username} = {
      home.packages = with pkgs; [ <package> ];

      # xdg.configFile, home.sessionVariables, programs.<name>, etc.
    };
  };
}
```

Key patterns used in modules:

- `home-manager.users.${config.common.username}` — wraps all user-level config
- `xdg.configFile.<name>` — copies config directories
- `home.sessionVariables` — sets environment variables
- `home.packages` — installs packages
- `programs.<name>` — enables HM-managed programs
- `lib.mkIf pkgs.stdenv.isDarwin` — platform-conditional logic
- `lib.optionalAttrs` — conditionally adds attrs

Some modules (like `1password`) use the `isDarwin` special arg or `inputs` for
flake inputs.

---

## Adding a New Module

1. Create `nix/common/modules/<name>/default.nix`
2. Follow the template above
3. Add `./modules/<name>` to the `imports` list in `nix/common/default.nix`
4. Hosts opt in with `brooklyn.programs.<name>.enable = true` or opt out with
   `false`
