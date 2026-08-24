# `nix/darwin/` — macOS (nix-darwin) Config

macOS-specific configuration using [nix-darwin](https://github.com/nix-darwin/nix-darwin)
with [nix-homebrew](https://github.com/zhaofengli/nix-homebrew) for declarative Homebrew.

---

## Entry Points

| File | Purpose |
| --- | --- |
| `default.nix` | Darwin base: imports `common/`, `modules/brew`, `modules/colima`, `modules/sikarugir`, `modules/stats`; Touch ID sudo; hostname |
| `home.nix` | macOS defaults: Dock, Finder, Safari, keyboard, screencapture via `targets.darwin.defaults` |

The darwin base is loaded when `flake.nix` matches a darwin hostname. It
imports `../common` for shared cross-platform config (and indirectly
`nix/common/profiles/gui`).

---

## Module Architecture

| Module | Path | What It Does |
| --- | --- | --- |
| **brew** | `modules/brew/` | nix-homebrew setup, Homebrew taps (as locked flake inputs), casks/brews, 1password shell plugins |
| **colima** | `modules/colima/` | Docker VM via Colima, installed and started through Homebrew `brew services` |
| **sikarugir** | `modules/sikarugir/` | Per-host helper used by `xerneas` (enabled by that host) |
| **stats** | `modules/stats/` | Stats menu bar app + macOS defaults for all widget preferences |

---

## nix-homebrew Setup (brew module)

- **`mutableTaps = false`** — all taps are locked flake inputs (reproducible)
- **`enableRosetta = false`**
- **Taps registered** (in root flake): `homebrew-core`, `homebrew-cask`, `jbhannah/pkpw`
- **Per-host taps** in `hosts/<name>/brew.nix`: e.g., comfey adds `withgraphite/homebrew-tap`
- **`homebrew.brews`** can use attributes: `{ name = "syncthing"; restart_service = "changed"; }`
- **`homebrew.casks`** can use `args.appdir` per-cask
- **`homebrew.masApps`** — Mac App Store apps by numeric ID

---

## macOS Defaults via `targets.darwin.defaults`

Set in `home.nix` using the format `"com.apple.<domain>" = { key = value; }`.
Common domains:

| Domain | What It Configures |
| --- | --- |
| `com.apple.desktopservices` | Network/USB .DS_Store creation |
| `com.apple.dock` | Autohide, minimize, recents, persistent apps/others |
| `com.apple.finder` | Sort order, status bar |
| `com.apple.menuextra.clock` | 24-hour format |
| `com.apple.safari` | Developer menu, autofill |
| `com.apple.screencapture` | Shadow, location |
| `NSGlobalDomain` | Keyboard repeat, show extensions, scroll bars |

---

## `lib.mkDefault` Pattern

The darwin base uses `lib.mkDefault` for some values:

```nix
networking.hostName = lib.mkDefault (lib.strings.toLower config.networking.computerName);
brooklyn.programs._1password.enable = lib.mkDefault true;
```

This means hosts can **override** these with plain assignment (lower priority).
Hosts set `networking.computerName` explicitly; `hostName` derives from it
automatically.

---

## Key Patterns

- **Launchd agents**: Defined via `home-manager.users.${username}.launchd.agents.<name>` (see colima module)
- **home.activation**: First-time file copy via `lib.hm.dag.entryAfter` (see colima module for `colima.yaml`)
- **`config.common.username`** is used everywhere (default: `brooklyn`)
- **Host-specific brew config**: Each host has `brew.nix` with `homebrew.brews`, `homebrew.casks`, `homebrew.masApps`
- **Host-specific HM overrides**: `home-manager.users.${config.common.username}` in the host `default.nix`

---

## Hosts

Three darwin hosts: `xerneas` (daily driver), `comfey` (work), `miraidon` (secondary).
See [hosts/AGENTS.md](hosts/AGENTS.md) for per-host differences.

```bash
# Apply specific host
darwin-rebuild switch --flake .#miraidon
```
