# `nix/system-manager/` — Standalone System-Manager Host(s)

Hosts provisioned via
[system-manager](https://github.com/numtide/system-manager) rather than
NixOS or nix-darwin. Builds through the root flake's `systemConfigs.<name>`
output and runs `system-manager switch` to activate.

Currently used for one host:

| Host | Purpose |
| --- | --- |
| `kalmiya` | Lightweight service-user host (separate physical/VPS box from tinkaton) |

---

## Layout

```
nix/system-manager/
├── default.nix                    # system-manager base (currently empty / not strictly required)
└── hosts/
    └── kalmiya/
        ├── default.nix            # Host config (system pkgs, trusted-users, allowUnfree)
        └── users/
            └── kalmiya/
                ├── default.nix    # User identity (isNormalUser, linger)
                └── home.nix       # Home-Manager config for the kalmiya user
```

The host `default.nix` imports:

- `../..` — the system-manager base
- `./users/kalmiya` — the user subtree

The flake exposes the host as `systemConfigs.kalmiya`, built with
`system-manager.lib.makeSystemConfig`.

---

## kalmiya

| Aspect | Detail |
| --- | --- |
| **Host** | `kalmiya` (separate physical/VPS box, NOT on tinkaton) |
| **Nix package** | Default `pkgs.nix` (not Lix — host uses upstream Nix) |
| **Platform** | `x86_64-linux` |
| **Allow unfree** | `true` |
| **Trusted users** | `debian` |
| **Overlays** | `inputs.llm-agents.overlays.shared-nixpkgs` |
| **System packages** | `git`, `system-manager` |
| **User** | `kalmiya`, `isNormalUser`, `linger = true`, SSH keys intentionally empty |

### User packages (via HM in `users/kalmiya/home.nix`)

`_1password-cli`, `fd`, `ffmpeg`, `git`, `gnumake`, `jq`, `libffi`, `llvm`,
`nodejs`, `python3`, `ripgrep`, `uv`. State version `26.05`. Enables `bash`,
`home-manager`, XDG with `localBinInPath`.

---

## Why Not NixOS?

system-manager is used because the box is a Debian/VPS host that doesn't
boot NixOS — system-manager overlays Nix configs on top of an existing
Linux install via `system-manager switch`. No boot loader, no NixOS
module system, just per-user/per-system Nix packages and config files.

---

## Adding a New System-Manager Host

1. Create `nix/system-manager/hosts/<name>/default.nix` and
   `nix/system-manager/hosts/<name>/users/<user>/{default.nix,home.nix}`
2. Add a `systemConfigs.<name>` entry to the root `flake.nix` using
   `system-manager.lib.makeSystemConfig`
3. Document the host here (add a row to the table and a subsection)
