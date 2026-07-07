# `nix/users/kalmiya/` — Kalmiya Standalone Flake

Standalone Home Manager configuration for the `kalmiya` service user on `tinkaton`.
**Completely independent** from the root flake — has its own `flake.nix`, `flake.lock`,
secrets, and nixpkgs pin.

---

## Key Files

| File | Purpose |
|---|---|
| `flake.nix` | Standalone flake: `home-manager.lib.homeManagerConfiguration` with its own inputs |
| `home.nix` | HM config: packages, bash, chromium, git, tmux, ripgrep, jq |
| `secrets.nix` | Own agenix secret definition for `openclaw-env.age` |
| `secrets/openclaw-env.age` | Age-encrypted env file |
| `flake.lock` | Pinned inputs (separate from root flake.lock) |
| `README.md` | Build/apply instructions |

---

## How It Works

1. The root flake's `nix/nixos/modules/kalmiya/default.nix` creates the `kalmiya` system user
   with `linger = true` and `openssh.authorizedKeys.keys = [ ]` (no SSH access)
2. That same module points `home-manager.users.kalmiya` to `home.nix` in this directory
3. The standalone flake is NOT used by the root flake directly — it exists as a reference
   for building independently with `home-manager switch --flake .#kalmiya`

---

## What It Configures

| Category | Packages/Programs |
|---|---|
| **Languages** | python311, uv, gcc, gnumake |
| **Tools** | `_1password-cli`, `fd`, `ripgrep`, `jq`, `git`, `tmux`, `bash`, `yq`, `npm` |
| **Media** | `ffmpeg-headless`, `opus` |
| **Database** | `sqlite-vec` |
| **Browser** | `chromium.enable = true` |
| **Secrets** | `age.secrets.openclaw-env` |
| **PATH** | `home.sessionPath` prepends `~/.npm/bin` so globally-installed npm packages are on `PATH` |

---

## Build & Apply

```bash
cd nix/users/kalmiya
nix build .#homeConfigurations.kalmiya.activationPackage
sudo -u kalmiya ./result/activate

# Or if home-manager is available:
cd nix/users/kalmiya
home-manager switch --flake .#kalmiya
```

---

## Key Differences from Root Flake

| Aspect | Kalmiya | Root Flake |
|---|---|---|
| **Nixpkgs** | `nixpkgs-unstable` (own pin) | `nixpkgs-unstable` + `nixpkgs-25_11` + `nixpkgs-mongodb-7_0_21` |
| **Secrets** | `secrets.nix` in this directory | `secrets.nix` at repo root |
| **Architecture** | `x86_64-linux` only | `x86_64-linux` + `aarch64-darwin` |
| **HM entry point** | `home-manager.lib.homeManagerConfiguration` | `home-manager.nixosModules.home-manager` |
