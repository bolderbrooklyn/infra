# `nix/home-manager/hosts/` — Per-Host Home-Manager Configs

Hosts that build through `home-manager.lib.homeManagerConfiguration`
(standalone home-manager) rather than NixOS/nix-darwin. Each host:

- Lives under `hosts/<name>/default.nix`
- Imports one or more per-user configs from `../users/<name>/`
- Sets host-specific overlays, machine-level options, and service configs
- Is exposed by the root flake as a top-level `homeConfigurations.<host>.<user>`
  attribute

Currently one host:

| Host | User | Role |
| --- | --- | --- |
| `archaludon` | `brooklyn` | `frosmoth` — daily-driver Linux desktop with NVIDIA GPU |

---

## archaludon (`frosmoth`)

### What `default.nix` Configures

- Imports `../users/brooklyn` (per-user HM config)
- Sets `brooklyn.gui.enable = true` (enables `ghostty`, `neovide`, `obsidian`)
- Configures `programs.git.settings.gpg.ssh.program = "/opt/1Password/op-ssh-sign"`
  (1Password SSH signing)
- Defines Syncthing folder configs:
  - `~/Sync` → device IDs: frosmoth, miraidon, tinkaton, xerneas
  - `~/Documents/Obsidian` → device IDs: frosmoth, kalmiya
  - `/run/media/brooklyn/Storage/Emulation` → device IDs: frosmoth, miraidon, tinkaton, xerneas
- Enables NVIDIA proprietary drivers via `nixpkgs.config.nvidia.acceptLicense`
  and `targets.genericLinux.gpu.nvidia`
- Currently pinned to NVIDIA driver `610.57.04` (sha256 hash baked in)

### Build & Activate

```bash
home-manager switch --flake .#archaludon.brooklyn
```

---

## Adding a New Home-Manager Host

1. Create `nix/home-manager/hosts/<name>/default.nix`
2. Import one or more users via `../users/<user>`
3. Add `homeConfigurations.<name>.<user>` to the root `flake.nix`
4. Document the host here (add a row to the table and a subsection)
