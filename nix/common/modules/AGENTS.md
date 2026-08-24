# `nix/common/modules/` — Shared Module Inventory

This directory contains cross-platform tools and applications. **Every module is
imported globally by `nix/common/default.nix`** and exposes a
`brooklyn.programs.<name>.enable` toggle. Hosts opt in or out via the toggle —
no per-host module imports, no commented imports.

The default for each toggle reflects whether the tool is useful for every host
in the grouping: `true` for lightweight universal tools, `false` for heavyweight
or niche ones (agent CLIs, SDKs, alternative shells).

---

## Module Inventory

| Module | Option Path | Default | Notes |
| --- | --- | --- | --- |
| `1password` | `brooklyn.programs._1password.enable` | `false` | Uses `isDarwin` special arg; SSH agent socket path differs per platform. `nix/darwin/default.nix` sets `lib.mkDefault true` so every darwin host gets it. |
| `buku` | `brooklyn.programs.buku.enable` | `false` | Bookmark manager |
| `docker` | `brooklyn.programs.docker.enable` | `true` | Docker packages for home-manager |
| `fish` | `brooklyn.programs.fish.enable` | `true` | Custom functions, vi key bindings; `programs.fish.defaultShell = true` makes it the default shell |
| `gcloud-cli` | `brooklyn.programs.gcloud-cli.enable` | `false` | Google Cloud SDK + SQL proxy |
| `gnupg` | `brooklyn.programs.gnupg.enable` | `true` | GPG agent with `pinentry_mac` on darwin |
| `kubectl` | `brooklyn.programs.kubectl.enable` | `false` | kubectl + helm + k9s + kubecolor |
| `mise` | `brooklyn.programs.mise.enable` | `true` | Version manager. Note: blocked by an HM option rename (`programs.mise.settings` → `programs.mise.globalConfig.settings`) |
| `nushell` | `brooklyn.programs.nushell.enable` | `false` | Adds nushell to `environment.systemPackages` and `environment.shells` |
| `openssh` | `brooklyn.programs.openssh.enable` | `true` | Adds `services.openssh.extraConfig` (`PasswordAuthentication no`, `PermitRootLogin no`) |
| `powershell` | `brooklyn.programs.powershell.enable` | `false` | `extraConfig` sub-option lets other modules (brew, starship) inject shellenv into PowerShell config |
| `xonsh` | `brooklyn.programs.xonsh.enable` | `false` | Adds xonsh to `environment.systemPackages` and `environment.shells` |
| `yazi` | `brooklyn.programs.yazi.enable` | `true` | File manager |
| `zsh` | `brooklyn.programs.zsh.enable` | `true` | Zsh shell (enabled, not default) |

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

Some modules (like `1password`) use the `isDarwin` special arg or `inputs` for flake inputs.

---

## Adding a New Module

1. Create `nix/common/modules/<name>/default.nix`
2. Follow the template above
3. Add `./modules/<name>` to the `imports` list in `nix/common/default.nix` — this is automatic for every module
4. Hosts opt in with `brooklyn.programs.<name>.enable = true` or opt out with `false`
