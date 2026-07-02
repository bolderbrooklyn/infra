# `nix/nixos/hosts/tinkaton/` — tinkaton Host Config

The sole NixOS host — home server.

---

## Files

| File | Purpose |
|---|---|
| `default.nix` | Host config: imports all NixOS modules, sets secrets, NFS, boot, firewall, services |
| `hardware-configuration.nix` | **Auto-generated** by `nixos-generate-config` — do not edit manually |
| `secrets/` | Agenix-encrypted `.age` files (4 secrets) |

---

## What `default.nix` Configures

- **Imports** NixOS base (`../..`), GUI profile, and all service modules
- **Enables** `calibre` and `antigravity-cli` via `brooklyn.programs.*.enable`
- **Defines** all `age.secrets` paths
- **Sets** `hostName = "tinkaton"`, `stateVersion = "25.05"`
- **Opens** TCP ports 443 (HTTPS) and 3389 (RDP)
- **Configures** `boot.loader.systemd-boot`, `boot.kernelPackages = linuxPackages_latest`
- **Defines** NFS mounts for `/mnt/genesect/{sync,passport}` and Syncthing folder config
- **Enables** `openssh`, `printing`, `security.rtkit`
- **Schedules** weekly cron reboot: `0 2 * * 1` (Monday 2 AM, complements autoUpgrade at 1-5 AM)
- **Sets** user `brooklyn` password from agenix secret

---

## Secrets

| Secret Name | File | Used By |
|---|---|---|
| `romm` | `secrets/romm.age` | ROM manager |
| `gitea-actions-runner-forgejo` | `secrets/gitea-actions-runner-forgejo.age` | Forgejo CI runner |
| `gitea-actions-runner-codeberg` | `secrets/gitea-actions-runner-codeberg.age` | Codeberg CI runner |
| `password-brooklyn` | `secrets/password-brooklyn.age` | User login password |

All secrets encrypted with `brooklyn` + `tinkaton` SSH keys.

---

## Boot

| Aspect | Value |
|---|---|
| **Loader** | `systemd-boot` |
| **EFI** | `canTouchEfiVariables = true` |
| **Kernel** | `linuxPackages_latest` (tracks latest) |
| **CPU** | Intel (x86_64-linux), `kvm-intel` module loaded |

---

## Hardware

- `hardware-configuration.nix` auto-generated — contains UUIDs for root, boot, swap
- Root: ext4 on `/dev/disk/by-uuid/...`
- Boot: vfat on `/dev/disk/by-uuid/...`
- Initial ramdisk modules: `xhci_pci`, `ahci`, `nvme`, `usbhid`, `usb_storage`, `sd_mod`, `sdhci_pci`

---

## NFS Mounts

| Mount | Purpose |
|---|---|
| `/mnt/genesect/sync` | Syncthing sync folder |
| `/mnt/genesect/passport` | Transmission downloads |

Additional NFS mounts for `/mnt/genesect/media` and `/mnt/genesect/forgejo` are
defined in their respective service modules.
