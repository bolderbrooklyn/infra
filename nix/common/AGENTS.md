# `nix/common/` — Cross-Platform Shared Config

This directory provides the base config shared by both **NixOS** and **nix-darwin**.
Every host loads this through its platform base (`nix/nixos/default.nix` or `nix/darwin/default.nix`).

---

## Entry Points

| File | Purpose |
|---|---|
| `default.nix` | Shared system config: Nix daemon, pkgs, users, timezone, imports most common modules |
| `home.nix` | Shared Home Manager config: SSH, zoxide, agenix HM module, shell aliases |

The common base is imported by the platform base via `../common` (e.g., `nix/nixos/default.nix` imports `../common`).

---

## What `default.nix` Configures

| Concern | Detail |
|---|---|
| **Nix package** | `pkgs.lixPackageSets.latest.lix` (Lix, not standard Nix) |
| **Experimental features** | `flakes`, `nix-command` |
| **Trusted users** | `config.common.username` |
| **Allow unfree** | `true` |
| **Overlays** | `llm-agents.overlays.default` |
| **Timezone** | `America/Los_Angeles` |
| **System packages** | `ruby_4_0`, `python314`, `vim`, `wget` |
| **Fish** | default shell (always on) |
| **Zsh** | enabled (always on) |
| **Primary user** | `brooklyn` (uid 1000 on NixOS), home at `/home/brooklyn` or `/Users/brooklyn` |

---

## How `config.common.username` Works

Defined in `default.nix:13-18` as `options.common.username` with default `"brooklyn"`.
Every module references it via `config.common.username`. Never hardcode a username.

## What `home.nix` Configures

- **`home-manager.sharedModules`** includes `agenix.homeManagerModules.default` → makes `age.secrets` available in HM context
- **`useGlobalPkgs = true`**
- **`backupFileExtension = "hm-backup"`** — existing dotfiles get backed up with this suffix
- **Per-user HM config** for `brooklyn`:
  - `age.identityPaths`: `~/.ssh/id_ed25519`
  - `home.shellAliases`: `l = "ls -alh"`
  - `home.stateVersion = "26.05"`
  - `home.packages`: `httpie`, `pkg-config`, `agenix` (built against Lix)
  - `programs.ssh` with conditional `enableDefaultConfig = false`
  - `programs.zoxide.enable = true`
  - `services.home-manager.autoExpire.enable = true`
  - `xdg.enable = true`, `xdg.localBinInPath = true`

---

## Module Registration

All modules listed in `default.nix:imports` are always **imported** at compile time.
Modules using `brooklyn.programs.<name>.enable` only activate at runtime when a host sets them.
Modules without a toggle (e.g., `fish`, `nvim`, `git`) are always active.

See [modules/AGENTS.md](modules/AGENTS.md) for the full module inventory.

---

## Gotchas

- `nix/common/default.nix` is imported by BOTH platform bases — anything added here affects ALL hosts
- `lib.mkDefault` in the darwin base (`nix/darwin/default.nix`) has lower priority, so hosts can override values with plain assignment
- The `home-manager.sharedModules` declaration in `home.nix` is what enables agenix inside HM modules
