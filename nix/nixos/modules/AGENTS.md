# `nix/nixos/modules/` — NixOS Service Modules

Service modules for the NixOS host `tinkaton`. These are imported directly by
`hosts/tinkaton/default.nix` (not through a central registry like common modules).

---

## Module Inventory

| Module | What It Does | NFS Dep? | Systemd Svc? | Firewall Ports |
|---|---|---|---|---|
| `audiobookshelf` | Audiobook server | yes (media) | yes | — |
| `crafty` | Minecraft server manager | — | — | — |
| `forgejo` | Git server + Gitea Actions runners (Forgejo + Codeberg) | yes (forgejo) | yes | 3000 |
| `jellyfin` | Media streaming (currently **disabled**) | yes (media) | — | — |
| `k3s` | Kubernetes server with external PostgreSQL manifest | — | yes | 6443 |
| `kalmiya` | Creates kalmiya system user, imports standalone HM flake | — | — | — |
| `lazylibrarian` | eBook/audiobook manager | — | — | — |
| `navidrome` | Music streaming (currently **disabled**) | yes (media) | — | — |
| `plex` | Plex Media Server + Tautulli | yes (media) | plex + tautulli | (openFirewall) |
| `podman` | Container runtime | — | — | — |
| `postgresql` | PostgreSQL 18 database server | — | yes | 5432 |
| `romm` | ROM manager | — | — | — |
| `servarr` | Transmission, Prowlarr, Radarr, Sonarr, Lidarr, Flaresolverr, Ombi | yes (media + passport) | all | (openFirewall) |
| `syncthing` | Syncthing with 4 devices, Tailscale QUIC addresses | — | yes | 8384 (GUI) |
| `tailscale` | Tailscale exit node + subnet router | — | — | (internal) |
| `tunarr` | TV channel streaming (currently **disabled**) | — | — | — |
| `unifi` | UniFi controller (currently **disabled**) | — | — | — |
| `unmanic` | Video file optimizer | — | — | — |

---

## Common Patterns

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

### `users.groups.media`

Services needing shared media access must be added to the `media` group (gid = 20100).
Defined inline in the module (see `plex/default.nix`).

### `systemd.tmpfiles.rules`

Used to pre-create directories with correct owner/permissions (see `forgejo/default.nix`).

---

## Adding a New Service Module

1. Create `nix/nixos/modules/<name>/default.nix`
2. For NFS-dependent services: add `systemd.services.<name>.requires = [ "mnt-genesect-media.mount" ]`
3. Add the import to `nix/nixos/hosts/tinkaton/default.nix`
4. If the service needs a secret, add it to `secrets.nix` and reference in host config

---

## Module Architecture Notes

- Unlike common modules, NixOS service modules **do not use** the `brooklyn.programs.*.enable` toggle pattern — they're imported and activated directly
- Disabled services are commented out in the host's imports list (e.g., `# ../../modules/jellyfin`)
- The `tailscale` module is imported through `nix/nixos/default.nix` (not through the host)
