# `nix/nixos/` — Linux (NixOS) Config

NixOS-specific configuration for the home server `tinkaton`.

---

## Entry Points

| File | Purpose |
|---|---|
| `default.nix` | NixOS base: agenix, catppuccin, HM, networking (systemd-resolved + nftables), firewall, users, autoUpgrade |
| `hosts/tinkaton/default.nix` | Host config: NFS mounts, secrets, boot config, firewall, enabled services |

The NixOS base is loaded when `flake.nix` matches the NixOS host. It imports `../common`.

---

## What `default.nix` Configures

| Concern | Detail |
|---|---|
| **Agents** | `agenix.nixosModules.default` |
| **Theming** | `catppuccin.nixosModules.catppuccin` — mocha flavor, with `autoEnable = true` to suppress a NixOS evaluation warning |
| **Home Manager** | `home-manager.nixosModules.home-manager` |
| **Networking** | `networkmanager` with `systemd-resolved` DNS |
| **Firewall** | `nftables.enable = true` (not iptables) |
| **Users** | `mutableUsers = false`; `brooklyn` with `networkmanager` + `wheel` groups |
| **Auto-upgrade** | Weekly, 01:00-05:00 window, auto-reboot, flake from `codeberg.org/bolderbrooklyn/infra` |
| **Locale** | `en_US.UTF-8` everywhere |
| **Nix-ld** | Enabled (for running unpatched binaries) |
| **SSH** | `openssh.openFirewall = true` |
| **Resolved** | `services.resolved.enable = true` |
| **Module** | All `nix/nixos/modules/*` loaded globally via `imports` in `nix/nixos/default.nix`; each module exposes `brooklyn.programs.<name>.enable` (default `true`) |

---

## Key Patterns

### Systemd Service Ordering with NFS

Services depending on NFS mounts must declare them in `systemd.services.<name>.requires`:

```nix
systemd.services.plex.requires = [ "mnt-genesect-media.mount" ];
```

The mount unit name follows the path: `/mnt/genesect/media` → `mnt-genesect-media.mount`.

### Cascading Service Dependencies

The servarr module shows a pattern where services depend on each other in a chain:

```
mnt-genesect-media.mount
  └─ transmission.service
      ├─ prowlarr.service
      ├─ radarr.service
      ├─ sonarr.service
      └─ lidarr.service
```

### Shared Media Group

Services that access shared NFS storage use the `media` group (`gid = 20100`):

```nix
users.groups.media = {
  gid = 20100;
  members = [ "plex" ];
};
```

### `systemd.tmpfiles.rules`

Used to pre-create directories with correct ownership:

```nix
systemd.tmpfiles.rules = [
  "d ${forgejo.storageDir}/backups 0755 forgejo forgejo -"
];
```

---

## Agenix Setup

- `agenix.nixosModules.default` is imported in `default.nix`
- `age.secrets` are defined in the host config (`hosts/tinkaton/default.nix`) pointing to `.age` files
- Decrypted at activation — path available as `config.age.secrets.<name>.path`
- Current secrets: `romm`, `gitea-actions-runner-forgejo`, `gitea-actions-runner-codeberg`, `password-brooklyn`

---

## Tailscale

- Module at `modules/tailscale/default.nix`
- Exit node + subnet router (`useRoutingFeatures = "both"`)
- `TS_DEBUG_FIREWALL_MODE=nftables` required for compatibility with nftables
- Tailnet: `anteater-wall.ts.net`

---

## Firewall Convention

- `networking.firewall.allowedTCPPorts` — opened per-service in each module or host config
- `networking.firewall.trustedInterfaces` — used for `podman+` in forgejo module (allows cache actions)
- nftables is the backend (not iptables)
- Tailscale uses its own firewall rules

---

## NFS Mounts (defined in host + service modules)

| Mount | Defined In | Device |
|---|---|---|
| `/mnt/genesect/media` | `modules/plex/default.nix` | `genesect.home.local:/nfs/Media` |
| `/mnt/genesect/sync` | `hosts/tinkaton/default.nix` | `genesect.home.local:/nfs/Sync` |
| `/mnt/genesect/passport` | `hosts/tinkaton/default.nix` | `genesect.home.local:/nfs/Passport` |
| `/mnt/genesect/forgejo` | `modules/forgejo/default.nix` | `genesect.home.local:/nfs/Forgejo` |

NFS mounts are `nfs` type with `noatime` (and `nodiratime` for media).
