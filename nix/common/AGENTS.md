# `nix/common/` — Cross-Platform Shared Config

This directory provides the base config shared by both **NixOS** and **nix-darwin**.
Every host loads this through its platform base (`nix/nixos/default.nix` or
`nix/darwin/default.nix`).

> For the **home-manager-only** equivalent (per-user `brooklyn.*` namespace,
> user packages, syncthing, GUI profile), see
> [`nix/home-manager/AGENTS.md`](../home-manager/AGENTS.md).

---

## Entry Points

| File | Purpose |
| --- | --- |
| `default.nix` | Shared system config: Nix/Lix daemon, pkgs, users, timezone, imports most common modules |
| `home.nix` | Shared Home Manager config: agenix HM module, SSH, per-user shell aliases, base packages |

The common base is imported by the platform base via `../common` (e.g.,
`nix/nixos/default.nix` imports `../common`).

---

## What `default.nix` Configures

| Concern | Detail |
| --- | --- |
| **Nix package** | `pkgs.lixPackageSets.latest.lix` (Lix, not standard Nix) |
| **Experimental features** | `flakes`, `nix-command` |
| **Trusted users** | `config.common.username` |
| **Allow unfree** | `true` |
| **Overlays** | `lixPackageSets.latest.lix` + `llm-agents.overlays.shared-nixpkgs` |
| **Garbage collection** | `nix.gc.automatic = true`, `nix.optimise.automatic = true`, `auto-optimise-store = true` |
| **Timezone** | `America/Los_Angeles` |
| **System packages** | `ruby_4_0`, `python314`, `vim`, `wget` |
| **Fish** | `programs.fish.defaultShell = true` (always on) |
| **Primary user** | `brooklyn` (uid from NixOS auto, home at `/home/brooklyn` or `/Users/brooklyn`) |
| **Primary user SSH key** | Hardcoded `ssh-ed25519` key pinned in `users.users.${username}.openssh.authorizedKeys` |
| **Imported modules** | `home.nix`, `modules/1password`, `modules/fish`, `modules/nushell`, `modules/openssh`, `modules/powershell`, `modules/xonsh`, `modules/zsh` |

`options.common.username` is defined in `default.nix` with default `"brooklyn"`.
Every module references it via `config.common.username`. Never hardcode a username
at the NixOS/darwin layer.

## What `home.nix` Configures

Pulled in as `home-manager.sharedModules`, so it applies to **every** user
on every host that imports `nix/common/`:

- **`home-manager.sharedModules`** includes `agenix.homeManagerModules.default`
  → makes `age.secrets` available in HM context
- **`home-manager.extraSpecialArgs`** forwards `catppuccin`, `llm-agents`,
  `nix-obsidian-extensions` to every HM module
- **`useGlobalPkgs = true`** (via the platform base)
- **`backupFileExtension = "hm-backup"`** — existing dotfiles get backed up
  with this suffix
- **Per-user HM config** for `brooklyn`:
  - `age.identityPaths`: `${home}/.ssh/id_ed25519`
  - `home.shellAliases`: `l = "ls -alh"`
  - `home.stateVersion = "26.05"`
  - `home.enableNixpkgsReleaseCheck = false`
  - `home.packages`: `httpie`, `pkg-config`, plus `agenix` (rebuilt against Lix)
  - `programs.ssh.enable = true` with `enableDefaultConfig = false`

> **Not** in `nix/common/home.nix` (despite earlier docs):
> `programs.zoxide.enable`, `services.home-manager.autoExpire`,
> `xdg.enable`/`xdg.localBinInPath` — those live in
> `nix/home-manager/default.nix` and the per-user
> `nix/home-manager/users/brooklyn/default.nix`.

---

## Module Registration

All modules listed in `default.nix:imports` are always **imported** at compile time.
Modules using `brooklyn.programs.<name>.enable` only activate at runtime when a host sets them.
Modules without a toggle (e.g., `fish`, `nvim`, `git`) are always active.

See [modules/AGENTS.md](modules/AGENTS.md) for the full module inventory.

---

## Gotchas

- `nix/common/default.nix` is imported by BOTH platform bases — anything added
  here affects ALL NixOS and darwin hosts
- `lib.mkDefault` in the darwin base (`nix/darwin/default.nix`) has lower
  priority, so hosts can override values with plain assignment
- The `home-manager.sharedModules` declaration in `home.nix` is what enables
  agenix inside HM modules
- The home-manager-only modules (`nix/home-manager/modules/programs/*`) are
  **not** loaded here — those live in their own layer and are activated
  per-user via `nix/home-manager/users/<name>/default.nix`
