# `nix/home-manager/profiles/gui/` — Home-Manager GUI Profile

Wraps GUI-only home-manager modules (`ghostty`, `neovide`, `obsidian`)
behind a single `brooklyn.gui.enable` toggle. Per-user HM configs flip
this toggle to opt in to the GUI toolset.

> Cross-platform GUI apps (terminals, editors that work on both NixOS
> and macOS) live in
> [`nix/common/profiles/gui/`](../../../common/profiles/gui/AGENTS.md) — they
> are imported through the platform base, not through this profile.

---

## Layout

```
nix/home-manager/profiles/gui/
├── default.nix                            # Exposes brooklyn.gui.enable, imports modules/programs
└── modules/
    └── programs/
        ├── default.nix                    # Imports each program below
        ├── ghostty/default.nix            # brooklyn.programs.ghostty.enable
        ├── neovide/default.nix            # brooklyn.programs.neovide.enable
        └── obsidian/default.nix           # brooklyn.programs.obsidian.enable
```

---

## How It's Wired

1. `nix/home-manager/default.nix` imports `./profiles/gui` so every
   user/host that loads the home-manager base gets the toggle
2. `default.nix` defines
   `options.brooklyn.gui.enable = lib.mkEnableOption "gui"` and imports
   `./modules/programs`
3. The per-user config (`nix/home-manager/users/brooklyn/default.nix`)
   sets `brooklyn.gui.enable = true` (gate-controlled via a `guiEnable`
   let-binding), which causes each GUI module's
   `lib.mkIf config.brooklyn.gui.enable` block to fire

---

## Module Inventory

| Module | Option Path | Notes |
| --- | --- | --- |
| `ghostty` | `brooklyn.programs.ghostty.enable` | Terminal emulator |
| `neovide` | `brooklyn.programs.neovide.enable` | Native Neovim GUI wrapper |
| `obsidian` | `brooklyn.programs.obsidian.enable` | Obsidian vault (uses `nix-obsidian-extensions` overlay) |

---

## Adding a New GUI Module

1. Create `nix/home-manager/profiles/gui/modules/programs/<name>/default.nix`
2. Follow the standard toggle template:

   ```nix
   { config, lib, pkgs, ... }:
   {
     options.brooklyn.programs.<name>.enable = lib.mkEnableOption "<name>";
     config = lib.mkIf config.brooklyn.programs.<name>.enable { ... };
   }
   ```

3. Add the import to `modules/programs/default.nix`
4. The user's `brooklyn.gui.enable` gate (and the per-module toggle)
   together control activation — modules here should NOT auto-enable
   with `brooklyn.gui.enable`; require the user to flip the module
   toggle explicitly
