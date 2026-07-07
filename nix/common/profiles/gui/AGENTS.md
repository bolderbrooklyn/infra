# `nix/common/profiles/gui/` — Cross-Platform GUI Apps

This profile defines GUI applications (terminals, editors) available on both
NixOS and macOS. It is imported by the NixOS GUI profile (`nix/nixos/profiles/gui/`)
and the darwin base (`nix/darwin/default.nix`).

---

## Module List

All modules live in `modules/`:

| Module | Togglable | Default |
|---|---|---|
| `alacritty` | `brooklyn.programs.alacritty.enable` | off |
| `calibre` | `brooklyn.programs.calibre.enable` | off |
| `cursor` | `brooklyn.programs.cursor.enable` | off |
| `ghostty` | `brooklyn.programs.ghostty.enable` | **on** (in `default.nix`) |
| `kitty` | `brooklyn.programs.kitty.enable` | off |
| `neovide` | `brooklyn.programs.neovide.enable` | **on** (in `default.nix`) |
| `qutebrowser` | `brooklyn.programs.qutebrowser.enable` | off |
| `rio` | `brooklyn.programs.rio.enable` | off |
| `vscode` | `brooklyn.programs.vscode.enable` | off |
| `warp-terminal` | `brooklyn.programs.warp-terminal.enable` | off |
| `zed` | `brooklyn.programs.zed.enable` | off |

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

GUI modules use `pkgs.stdenv.isDarwin` for platform-conditional logic:

- **Ghostty**: uses `ghostty-bin` on Darwin (from Homebrew), source build on NixOS; fullscreen mode conditional; `shell-integration-features = "ssh-terminfo"` for remote-host terminfo sync
- **Neovide**: wraps Neovim in a native GUI window
- Most other modules are unconditional (same package on both platforms)

---

## Registering New GUI Modules

Add the import to `modules/<name>/default.nix` in this directory, then add it to the
`imports` list in `default.nix`. Unlike regular common modules, GUI modules are NOT
imported through `nix/common/default.nix` — they're only loaded through the profile chain.
