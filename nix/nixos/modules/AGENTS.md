# `nix/nixos/modules/` — NixOS Service Modules

Service modules for NixOS hosts. Every module in this directory is imported
globally by `nix/nixos/default.nix` and exposes a `brooklyn.programs.<name>.enable`
toggle (default `true`). Hosts opt in or out via the toggle — no per-host imports,
no commented imports.

> The `kalmiya` module here is **broken**: its import path
> `../../../users/kalmiya/home.nix` does not resolve. kalmiya is actually
> provisioned by the standalone system-manager flake at
> `nix/system-manager/hosts/kalmiya/`. See the root AGENTS.md Anti-Patterns.

---

## Module Inventory

| Module | What It Does | Default | NFS Dep? | Systemd Svc? | Firewall Ports |
| --- | --- | --- | --- | --- | --- |
| `audiobookshelf` | Audiobook server | true | yes (media) | yes | — |
| `crafty` | Minecraft server manager | true | — | — | — |
| `forgejo` | Git server + Gitea Actions runners (Forgejo + Codeberg) | true | yes (forgejo) | yes | 3000 |
| `jellyfin` | Media streaming | true (off on tinkaton) | yes (media) | — | — |
| `k3s` | Kubernetes server with external PostgreSQL manifest | true (off on tinkaton) | — | yes | 6443 |
| `kalmiya` | Creates kalmiya system user, imports standalone HM flake | true | — | — | — |
| `lazylibrarian` | eBook/audiobook manager | true | — | — | — |
| `media` | Shared `media` group/user + NFS mount for `/mnt/genesect/media` | true | provides | — | — |
| `navidrome` | Music streaming | true (off on tinkaton) | yes (media) | — | — |
| `plex` | Plex Media Server + Tautulli | true | yes (media) | plex + tautulli | (openFirewall) |
| `podman` | Container runtime (foundational for lazylibrarian/romm/tunarr/unmanic) | true | — | — | — |
| `postgresql` | PostgreSQL 18 database server | true | — | yes | 5432 |
| `romm` | ROM manager | true | — | — | — |
| `servarr` | Transmission, Prowlarr, Radarr, Sonarr, Lidarr, Flaresolverr, Ombi | true | yes (media + passport) | all | (openFirewall) |
| `syncthing` | Syncthing with 6 devices, Tailscale QUIC addresses | true | — | yes | 8384 (GUI) |
| `tailscale` | Tailscale exit node + subnet router | true | — | — | (internal) |
| `tunarr` | TV channel streaming | true (off on tinkaton) | — | — | — |
| `unifi` | UniFi controller | true (off on tinkaton) | — | — | — |
| `unmanic` | Video file optimizer | true (off on tinkaton) | — | — | — |

The "off on tinkaton" column reflects explicit `enable = false` flags in
`nix/nixos/hosts/tinkaton/default.nix`.

---

## Common Patterns

### Toggle Wrapper

Every module follows this template:

```nix
{ config, lib, pkgs, ... }:
{
  imports = [ ../media ];  # shared deps stay at module level

  options.brooklyn.programs.<name>.enable = lib.mkEnableOption "<name>" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.<name>.enable {
    # original module body
  };
}
```

`imports` and `options` stay at the module level; everything else goes inside
the `lib.mkIf` so the toggle fully gates the module's behavior.

### NFS Mount Dependency

```nix
systemd.services.<name>.requires = [ "mnt-genesect-media.mount" ];
```

See [nixos/AGENTS.md](../AGENTS.md) for the cascading dependency chain in servarr.

### Firewall Ports

```nix
networking.firewall.allowedTCPPorts = [ <port> ];
```

Or use `openFirewall = true` where the NixOS module provides it.

### Shared `media` Group

Services needing shared media access import `../media` and (optionally) append
themselves to the group:

```nix
imports = [ ../media ];
users.groups.media.members = [ "<name>" ];
```

The `media` group/user/NFS mount is defined by the `media` module itself
(`users.groups.media`, `users.users.media`, `fileSystems."/mnt/genesect/media"`).

### `systemd.tmpfiles.rules`

Used to pre-create directories with correct owner/permissions (see `forgejo/default.nix`).

---

## Adding a New Service Module

1. Create `nix/nixos/modules/<name>/default.nix`
2. Follow the module template below (`brooklyn.programs.<name>.enable` toggle, body wrapped in `lib.mkIf`)
3. Add the import to `nix/nixos/default.nix` (every module in this directory is loaded there)
4. Hosts enable the service with `brooklyn.programs.<name>.enable = true` in their `default.nix`, or opt out with `false`

For NFS-dependent services: add `systemd.services.<name>.requires = [ "mnt-genesect-media.mount" ]`. The shared media user/group/NFS mount lives in `nix/nixos/modules/media/` — import it with `imports = [ ../media ];` if your service needs it.

If the service needs a secret, add it to `secrets.nix` and reference in host config.

---

## Module Architecture Notes

- Every NixOS service module follows the `brooklyn.programs.<name>.enable` toggle pattern with `default = true`
- Hosts control services via toggles only — no per-host imports, no commented imports
- Modules that provide shared infrastructure (e.g. `media`) keep `default = true` so dependents always have what they need
- The `tailscale` module is imported through `nix/nixos/default.nix` like every other service module
