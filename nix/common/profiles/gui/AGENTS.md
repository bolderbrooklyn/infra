# `nix/common/profiles/gui/` — Cross-Platform GUI Apps

GUI applications (terminals, editors) available on **both** NixOS and macOS.
Imported by the NixOS GUI profile (`nix/nixos/profiles/gui/`) and the darwin
base (`nix/darwin/default.nix`).

> Home-manager-only GUI apps (`ghostty`, `neovide`, `obsidian`) live in
> `nix/home-manager/profiles/gui/modules/programs/` and are gated by
> `brooklyn.gui.enable` per-user. See
> [`nix/home-manager/profiles/gui/AGENTS.md`](../../../home-manager/profiles/gui/AGENTS.md).

---

## Module List

All modules live in `modules/`:

| Module | Togglable | Default |
| --- | --- | --- |
| `alacritty` | `brooklyn.programs.alacritty.enable` | off |
| `calibre` | `brooklyn.programs.calibre.enable` | off |
| `cursor` | `brooklyn.programs.cursor.enable` | off |
| `kitty` | `brooklyn.programs.kitty.enable` | off |
| `qutebrowser` | `brooklyn.programs.qutebrowser.enable` | off |
| `rio` | `brooklyn.programs.rio.enable` | off |
| `vscode` | `brooklyn.programs.vscode.enable` | off |
| `warp-terminal` | `brooklyn.programs.warp-terminal.enable` | off |
| `zed` | `brooklyn.programs.zed.enable` | off |

> `ghostty` and `neovide` were moved out to the home-manager GUI profile
> (`nix/home-manager/profiles/gui/modules/programs/`) so they can be enabled
> per-user. They no longer live here.

---

## Shared Config

The `font/` submodule provides a shared `gui.font` option:

```nix
options.gui.font = {
  name = lib.mkOption { default = "FiraCode Nerd Font Mono"; };
  size = lib.mkOption { default = 12; };
};
```

Any GUI module can access it via `config.gui.font.name` / `config.gui.font.size`.
The NixOS GUI profile overrides `gui.font.size = 13`.

---

## Platform Patterns

GUI modules use `pkgs.stdenv.isDarwin` for platform-conditional logic. Most
modules are unconditional (same package on both platforms).

---

## Registering New GUI Modules

Add the import to `modules/<name>/default.nix` in this directory, then add it
to the `imports` list in `default.nix`. Unlike regular common modules, GUI
modules are **not** imported through `nix/common/default.nix` — they're only
loaded through the profile chain.
