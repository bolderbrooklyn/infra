# Project Overview: `infra`

This repository manages the system configuration and dotfiles for Jesse Brooklyn
Hannah's machines. It uses **Nix Flakes** with **Lix** (a Nix fork) for
reproducible infrastructure as code across **NixOS (Linux)** and
**nix-darwin (macOS)** systems.

---

## Host Inventory

| Host | Platform | Architecture | Role |
|---|---|---|---|
| `tinkaton` | NixOS | x86_64-linux | Home server: media (Plex, *arr stack), Forgejo, k3s, Syncthing |
| `miraidon` | nix-darwin | aarch64-darwin | Daily driver MacBook |
| `comfey` | nix-darwin | aarch64-darwin | Work laptop (nclusion) |
| `xerneas` | nix-darwin | aarch64-darwin | Secondary/desktop Mac |
| `kalmiya` | NixOS + standalone HM | x86_64-linux | Service user on tinkaton (in `/nix/users/kalmiya/`) |

Key difference: `kalmiya` has its **own standalone flake** at `/nix/users/kalmiya/flake.nix` — it is NOT managed through the root flake. It uses `home-manager.lib.homeManagerConfiguration` directly.

All darwin hosts share the same `system.stateVersion = 6`. The NixOS host `tinkaton` uses state version `25.05`.

---

## Key Technologies

- **Nix Implementation:** [Lix](https://lix.systems/) (not standard Nix) — set via `pkgs.lixPackageSets.latest.lix`
- **Nix config core:** `nixpkgs-unstable` with `allowUnfree = true`
- **macOS config:** [nix-darwin](https://github.com/nix-darwin/nix-darwin) (master branch)
- **User config:** [Home Manager](https://github.com/nix-community/home-manager) — wraps most user-level/dotfile config
- **Secrets:** [agenix](https://github.com/ryantm/agenix) — age-encrypted `.age` files
- **macOS packages:** [nix-homebrew](https://github.com/zhaofengli/nix-homebrew) — declarative Homebrew via flake inputs (taps are locked inputs for reproducibility)
- **Theming:** [Catppuccin](https://catppuccin.com/) (mocha flavor) — `catppuccin.autoEnable = true` enables it everywhere possible
- **Development shell:** [devenv](https://devenv.sh/) — provides `nixd`, `nixfmt`, `statix`, `gnumake`
- **Secret management:** **Agenix** — age-encrypted files; identity key is `~/.ssh/id_ed25519` by default

---

## Architecture & Directory Structure

```
├── flake.nix                        # Root flake: defines all hosts & their modules
├── secrets.nix                      # Agenix secret definitions (maps .age files to public keys)
├── nix/
│   ├── common/
│   │   ├── default.nix              # Shared NixOS/darwin config (nix settings, timezone, users, pkgs)
│   │   ├── home.nix                 # Shared Home Manager config (shell aliases, SSH, zoxide)
│   │   ├── profiles/
│   │   │   └── gui/                 # GUI app modules (alacritty, ghostty, kitty, vscode, cursor, etc.)
│   │   └── modules/                 # ~35 shared modules (see below)
│   ├── darwin/
│   │   ├── default.nix              # Darwin base config (brew, colima, stats + imports common/)
│   │   ├── home.nix                 # Darwin-specific HM (macOS defaults, dock, Finder, Safari)
│   │   ├── hosts/{comfey,miraidon,xerneas}/  # Per-host: default.nix + brew.nix (+ optional config/)
│   │   └── modules/{brew,colima,stats,sikarugir}/
│   ├── nixos/
│   │   ├── default.nix              # NixOS base config (agenix, catppuccin, HM, networking, firewall)
│   │   ├── hosts/tinkaton/          # Host: default.nix + hardware-configuration.nix + secrets/
│   │   ├── modules/{servarr,forgejo,plex,k3s,tailscale,…}/  # ~18 service modules
│   │   ├── profiles/gui/            # NixOS GUI profile (KDE Plasma 6, SDDM, PipeWire)
│   │   └── modules/kalmiya/         # Creates kalmiya system user, imports standalone HM flake
│   └── users/kalmiya/               # Standalone flake for kalmiya user (separate from root flake!)
├── k8s/traefik.yml                  # HelmChartConfig for Traefik on k3s
├── Makefile                         # Convenience wrapper for darwin-rebuild / nixos-rebuild
├── bootstrap.sh                     # Initial machine setup (install Lix + apply flake)
├── devenv.nix / devenv.yaml         # Local dev environment (nixd, nixfmt, statix)
└── cspell.json                      # Spell check config (mostly empty)
```

### Module System: Three Layers

| Layer | Scope | Entry Point | Key Options Pattern |
|---|---|---|---|
| **Common** (`nix/common/modules/`) | Cross-platform apps & tools | `nix/common/default.nix` imports ~25 modules | Some use `brooklyn.programs.*.enable` toggle, some are always-on |
| **Darwin** (`nix/darwin/modules/`) | macOS-specific | `nix/darwin/default.nix` imports 4 modules | Uses `brooklyn.programs.*.enable` + Homebrew + launchd |
| **NixOS** (`nix/nixos/modules/`) | Linux services | `nix/nixos/hosts/tinkaton/default.nix` imports ~16 modules | Directly enables systemd services, firewall, NFS mounts |

### Module Registration: How Feature Toggling Works

Many modules use a custom `brooklyn.programs.<name>.enable` option pattern:

```nix
# In the module:
options.brooklyn.programs.crush.enable = lib.mkEnableOption "crush";
config = lib.mkIf config.brooklyn.programs.crush.enable { ... };

# In the host default.nix:
brooklyn.programs.crush.enable = true;
```

**This is NOT a standard Nix pattern.** It's a project-specific convention. Modules using this pattern are registered as **imports** at compile-time (in `nix/common/default.nix` or `nix/nixos/default.nix`) but only activate at runtime when the host enables them. Some modules (like `fish`, `nvim`, `git`) don't use this toggle and are always active.

### Control/Data Flow

```
User runs: make switch
  └─ Makefile detects platform (NixOS vs Darwin)
      └─ Runs: darwin-rebuild switch --flake .#$(hostname -s)
          └─ flake.nix matches hostname to configuration
              ├─ Loads host dir (nix/{darwin,nixos}/hosts/<hostname>/)
              ├─ Host default.nix imports:
              │   ├─ Platform base (nix/{darwin,nixos}/default.nix)
              │   │   └─ Which imports nix/common/default.nix
              │   │       └─ Which imports nix/common/home.nix for HM config
              │   ├─ Platform-specific modules
              │   └─ Common modules (selected subset)
              └─ Evaluates all modules + applies config
```

### How Secrets Work

1. **Define** in `/secrets.nix`: map path → list of authorized public keys
2. **Encrypt** with: `agenix -e <path>.age` (produces `.age` armored file)
3. **Decrypt at activation**: NixOS/darwin reads `age.secrets.<name>.file` → decrypts to `age.secrets.<name>.path`
4. **Identity key**: `~/.ssh/id_ed25519` (must be in the authorized keys in `secrets.nix`)

The SSH key used for signing commits is the **same public key** used for agenix decryption.

---

## Essential Commands

### Apply / Build

```bash
make switch     # Rebuild + activate (uses sudo on NixOS, sudo on darwin for switch)
make build      # Dry run (no sudo needed)
make boot       # Rebuild + boot into new generation (NixOS only)

# Manual equivalents (when Makefile isn't available):
# Darwin: darwin-rebuild switch --flake .#(hostname -s)
# NixOS:  sudo nixos-rebuild switch --flake .#(hostname -s)
```

### Update Dependencies

```bash
make up         # Full: nix flake update + devenv update + make switch
make update    # Flake inputs only: nix flake update
make devenv    # Devenv only: devenv update
```

### CI (Automated Weekly)

- **flake.yml**: Runs `nix flake update` weekly, creates PR on `update-flake-*` branch
- **devenv.yml**: Runs `devenv update` weekly, creates PR on `update-devenv-*` branch
- **auto-merge.yml**: Auto-merges PRs from dependabot and `update-flake-*`/`update-devenv-*` branches

Both CI workflows run on `ubuntu-latest` using `cachix/install-nix-action@v31`.

### Development

```bash
direnv allow     # Activates the devenv shell (via .envrc)
```

The devenv provides: `nixd` (LSP), `nixfmt` (formatter), `statix` (linter), `gnumake`.

---

## Important Patterns & Conventions

### Host Modules Import the Parent via `..`

A host's `default.nix` imports `../..` (the parent's `default.nix`) which in turn imports the platform base + common modules. This means the host config is the top-level entry point that composes all layers.

### Platform Conditionals via `isDarwin`

The flake passes `isDarwin = true/false` as a `specialArgs`. This is used in some modules (e.g., `1password`) to conditionally apply platform-specific config via `lib.mkIf (!isDarwin)`. Always check for this pattern when adding cross-platform features.

### Username

The default username is `brooklyn`, defined in `nix/common/default.nix` and inherited everywhere as `config.common.username`. The Kalmiya service user uses `kalmiya` (defined separately in its own module and standalone flake).

### SSH Signing & Git

- All commits are signed with **SSH keys** (not GPG)
- Git config uses `signer = "ssh-keygen"` with `format = "ssh"` and `signByDefault = true`
- The default branch is `trunk` (NOT main/master)
- Merge conflict style: `zdiff3`; diff tool: `delta` (side-by-side, line numbers)

### Nix Flakes

- All Homebrew taps are **locked as flake inputs** for reproducibility (`nix-homebrew.mutableTaps = false`)
- The flake follows `nixpkgs/nixpkgs-unstable` plus a pinned `nixpkgs-25_11` release channel for stability
- There's a specific pinned nixpkgs for MongoDB 7.0.21

### GUI Profile Pattern

The common GUI profile (`nix/common/profiles/gui/`) defines terminal emulators and editors available on all platforms. The NixOS GUI profile (`nix/nixos/profiles/gui/`) adds X11/KDE/Plasma/PipeWire and imports the common GUI profile. Darwin doesn't need extra GUI config since macOS provides the display server.

### Shared NFS Storage

The NixOS host `tinkaton` mounts several NFS shares from a NAS (`genesect.home.local`):

| Mount Point | Export | Used By |
|---|---|---|
| `/mnt/genesect/media` | `/nfs/Media` | Plex, Audiobookshelf, Jellyfin, *arr stack |
| `/mnt/genesect/sync` | `/nfs/Sync` | Syncthing |
| `/mnt/genesect/passport` | `/nfs/Passport` | Transmission downloads |
| `/mnt/genesect/forgejo` | `/nfs/Forgejo` | Forgejo data, backups, LFS |

Many systemd services use `after`/`requires` on mount units (e.g., `mnt-genesect-media.mount`) to ensure NFS is available before the service starts. This is a common gotcha — adding a new service that depends on media storage MUST include these directives.

### Tailscale

- All hosts use Tailscale within the tailnet `anteater-wall.ts.net`
- Tailscale is configured as both an exit node and subnet router (`useRoutingFeatures = "both"`) on NixOS
- NixOS uses `TS_DEBUG_FIREWALL_MODE=nftables` for compatibility with nftables firewall

---

## Adding a New Module

1. Create `nix/{common,darwin,nixos}/modules/<name>/default.nix`
2. Follow the existing pattern:
   - Use `{ config, lib, pkgs, ... }:` as function args
   - If togglable: define `options.brooklyn.programs.<name>.enable = lib.mkEnableOption "<name>";`
   - Wrap config in `lib.mkIf config.brooklyn.programs.<name>.enable { ... }`
   - Use `config.common.username` for the primary user
3. Add the import to the parent `default.nix` (e.g., `nix/common/default.nix` for cross-platform modules)
4. Enable it in the host's `default.nix` if you used the togglable pattern

---

## Key Files Reference

| File | Purpose |
|---|---|
| `flake.nix` | Entry point: defines inputs, host configs, special args |
| `secrets.nix` | Agenix secrets map (public keys → encrypted files) |
| `Makefile` | Build/switch/update wrappers |
| `nix/common/default.nix` | Shared NixOS+Darwin system config base |
| `nix/common/home.nix` | Shared Home Manager config hub |
| `nix/darwin/default.nix` | Darwin base (brew, colima, stats) |
| `nix/darwin/home.nix` | Darwin macOS defaults (Dock, Finder, Safari, keyboard) |
| `nix/nixos/default.nix` | NixOS base (tailscale, networking, firewall, auto-upgrade) |
| `nix/users/kalmiya/flake.nix` | **Standalone flake** for kalmiya service user (not in root flake) |
| `bootstrap.sh` | First-time machine setup script |
| `devenv.nix` | Dev environment packages (nixd, nixfmt, statix) |
| `.envrc` | Direnv activation for devenv |

---

## Committing Changes

Always use `git commit -am` with a descriptive message. Commits are automatically
signed via the SSH signing key configured in `git` module. The default branch is
`trunk`.

---

## Gotchas & Non-Obvious Details

- **`make build` does NOT need sudo**, but `make switch` DOES
- The Makefile uses `hostname -s`, NOT `hostname` — if hosts have different domain suffixes, use `hostname -s`
- The `cspell.json` has an empty `words` list — all words are in `ignoreWords` instead
- `miraidon`'s SSH key is **commented out** in `secrets.nix` (no `.age` files use it), meaning `miraidon` can't decrypt secrets locally — only `tinkaton` keys are active
- `home-manager.sharedModules = [ agenix.homeManagerModules.default ]` makes agenix available inside HM — this is needed for modules that use `age.secrets` within HM context
- The nvim module ships its **entire config tree** as `config/` (Lua files for lazy.nvim, LSP, treesitter, etc.) — not just a few overrides
- The `nix/common/home.nix` sets `home-manager.backupFileExtension = "hm-backup"` — existing dotfiles get backed up with this extension before being replaced
- The `secrets.nix` uses `builtins.readFile` implicitly through the agenix convention (no function call needed) — just list the `.age` file path and public keys
