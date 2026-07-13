# Project `infra`

System configuration and dotfiles for Jesse Brooklyn Hannah's machines.
Uses **Nix Flakes** + **Lix** across **NixOS (Linux)** and **nix-darwin (macOS)**.

---

## Hosts

| Host | Platform | Arch | Role |
|---|---|---|---|
| `tinkaton` | NixOS | x86_64-linux | Home server: Plex, *arr, Forgejo, k3s, Syncthing |
| `miraidon` | nix-darwin | aarch64-darwin | Secondary/desktop Mac |
| `comfey` | nix-darwin | aarch64-darwin | Work laptop (nclusion) |
| `xerneas` | nix-darwin | aarch64-darwin | Daily driver MacBook |
| `kalmiya` | NixOS + standalone HM | x86_64-linux | Service user on tinkaton |

---

## Quick Start Commands

```bash
make switch        # Rebuild + activate (needs sudo)
make build         # Dry run (no sudo)
make boot          # NixOS only: rebuild + boot into new gen (needs sudo)
make update        # nix flake update
make up            # update + switch + devenv
direnv allow       # Activate devenv shell
```

---

## Code Map

Key symbols and where they're defined:

| Symbol | Type | Defined In | Refs | Role |
|---|---|---|---|---|
| `brooklyn.programs.*.enable` | Option pattern | `nix/{common/modules,common/profiles/gui/modules,darwin/modules}/*/default.nix` | 7 + 10 + 1 = 18 modules | Feature toggle convention; 7 in common modules, 10 in GUI profile, 1 in darwin |
| `isDarwin` | specialArg | `flake.nix:86-90` | 11 files | Platform conditional |
| `config.common.username` | Option | `nix/common/default.nix:13` | 50+ refs | Default user "brooklyn" |
| `age.secrets.<name>` | Agenix pattern | `secrets.nix` | 4 secrets | Decrypt at activation |
| `nix-homebrew` | Flake input | `flake.nix:48` | darwin hosts | Declarative brew with locked taps |
| `targets.darwin.defaults` | nix-darwin module | `nix/darwin/home.nix` | all darwin | macOS `defaults write` |
| `mnt-genesect-*.mount` | Systemd mount unit | `nix/nixos/modules/plex/default.nix` | 5+ services | NFS dependency ordering |
| `agent-instructions` | Common module | `nix/common/modules/agent-instructions/default.nix` | always-on | Writes shared guardrails to every enabled agent's global instruction file (claude-code, codex, opencode, pi-coding-agent, crush, copilot-cli, antigravity) |

## Directory Map & Quick Task Reference

| Task | Path | Doc |
|---|---|---|
| **Add cross-platform tool** | `nix/common/modules/` | [→](nix/common/modules/AGENTS.md) |
| **Add GUI editor/terminal** | `nix/common/profiles/gui/modules/` | [→](nix/common/profiles/gui/AGENTS.md) |
| **Add NixOS service** | `nix/nixos/modules/` | [→](nix/nixos/modules/AGENTS.md) |
| **Add macOS app** | `nix/darwin/hosts/<name>/brew.nix` | [→](nix/darwin/hosts/AGENTS.md) |
| **Manage secrets** | `secrets.nix` + `secrets/*.age` | — |
| **Update dependencies** | `make up` (project root) | — |
| **Debug module activation** | `nix/common/default.nix` | [→](nix/common/AGENTS.md) |
| **Standalone flake** | `nix/users/kalmiya/` | [→](nix/users/kalmiya/AGENTS.md) |
| **Cross-platform base** | `nix/common/` | [→](nix/common/AGENTS.md) |
| **Darwin platform** | `nix/darwin/` | [→](nix/darwin/AGENTS.md) |
| **NixOS platform** | `nix/nixos/` | [→](nix/nixos/AGENTS.md) |
| **tinkaton host** | `nix/nixos/hosts/tinkaton/` | [→](nix/nixos/hosts/tinkaton/AGENTS.md) |

---

## Key Conventions

- **Feature toggle**: `options.brooklyn.programs.<name>.enable = lib.mkEnableOption "<name>"`
- **Username**: `config.common.username` (default: `brooklyn`)
- **Platform conditional**: `isDarwin` special arg or `pkgs.stdenv.isDarwin`
- **Secrets**: agenix — encrypted `.age` files decrypted at activation via `~/.ssh/id_ed25519`
- **Git**: SSH-signed commits, branch `trunk`, merge style `zdiff3`, diff tool `delta`
- **All Homebrew taps** are locked flake inputs (`mutableTaps = false`)
- **`make switch` uses `hostname -s`** to pick the host config

---

## CI (Weekly)

- `flake.yml` → `nix flake update` → PR on `update-flake-*`
- `devenv.yml` → `devenv update` → PR on `update-devenv-*`
- `auto-merge.yml` → auto-squash-merge for dependabot + update PRs

Uses `cachix/install-nix-action@v31` on `ubuntu-latest`.

---

## Gotchas

- `make build` **no sudo**; `make switch / boot / check` **all need sudo**
- `cspell.json` uses `ignoreWords` (not `words`)
- miraidon's SSH key is **commented out** in `secrets.nix` → miraidon can't decrypt secrets locally
- `home-manager.backupFileExtension = "hm-backup"` — existing dotfiles get backed up before replacement
- `hardware-configuration.nix` is **auto-generated** — don't edit manually
- `system.stateVersion`: darwin = `6`, NixOS = `"25.05"`
- `devenv.yaml` uses `cachix/devenv-nixpkgs/rolling` (not a pinned channel)

## Anti-Patterns (Known Issues)

These are documented problem areas an agent should be aware of — not to perpetuate, but to recognize when working in the codebase.

- **Orphaned toggle**: `brooklyn.programs.antigravity-cli.enable` exists in `nix/common/modules/antigravity-cli/` but no host ever sets it to true. The `agent-instructions` module's `antigravityEnabled` check is therefore also dead. The module is still globally imported, so the package is installed but the `lib.mkIf enable` block never executes
- **Orphan module**: `nix/common/modules/superfile/` defines `programs.superfile.enable = true` but is not imported anywhere (not in `nix/common/default.nix`, not by any host)
- **`k8s/traefik.yml` is orphaned**: Not referenced by any Nix config. It's a Kubernetes HelmChartConfig living alongside Nix config. May be dead or managed out-of-band.
- **No build validation in CI**: Workflows only update dependencies (`nix flake update` / `devenv update`) — never run `nix flake check`, `nix build`, or `nix eval`. Config breakage only caught at activation time.
- **Codeberg/GitHub mismatch**: CI workflows target GitHub Actions (`cachix/install-nix-action`, `peter-evans/create-pull-request`, `gh pr merge`) but the repo lives on Codeberg. Workflows may never run.
- **kalmiya dual-management**: The NixOS module at `nix/nixos/modules/kalmiya/default.nix` imports `home.nix` directly from `../../../users/kalmiya/home.nix`, effectively bypassing the standalone flake's agenix and `allowUnfree` config. The standalone flake exists but its build pipeline is disconnected from the root system build.
- **Missing NFS mount for emulation**: Syncthing config references `/mnt/genesect/emulation/library` but no `fileSystems."/mnt/genesect/emulation"` mount is defined anywhere.

## Unique Styles

Non-standard patterns that differ from typical Nix/NixOS conventions:

- **Custom toggle namespace**: `brooklyn.programs.*.enable` — not standard `programs.*` or `services.*`. This is a project-specific convention used across all common modules.
- **Cross-layer callbacks**: The darwin `brew` module reads `brooklyn.programs.powershell.extraConfig` and injects homebrew shellenv into PowerShell config. Modules can reach across layers.
- **Commented imports as toggles**: The NixOS host uses `# ../../modules/jellyfin` to disable services rather than a boolean toggle. Comment/uncomment to enable/disable.
- **Standalone flake in monorepo**: `nix/users/kalmiya/flake.nix` has its own inputs, lock file, secrets, and nixpkgs pin — completely independent of the root flake but lives in the same repo.
- **Two-tier GUI profile**: Common GUI (12 modules for terminals/editors) is wrapped inside NixOS GUI (KDE Plasma 6, SDDM, PipeWire) for the Linux host. Darwin skips the NixOS wrapper.
- **Shared agent guardrails**: The `agent-instructions` module writes a single set of workspace, secrets, and shell-and-network rules to every enabled agent's global instruction file. Adding a new agent means adding a one-line `xdg.configFile` entry, not duplicating the prose.
