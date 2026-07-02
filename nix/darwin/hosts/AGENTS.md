# `nix/darwin/hosts/` — Per-Host Darwin Config

Each darwin host has its own directory with a `default.nix` and `brew.nix`.

---

## Common Structure

```
hosts/<name>/
├── brew.nix      # Per-host Homebrew packages (brews, casks, masApps, additional taps)
└── default.nix   # Host config: imports brew.nix + ../.. + common modules + host overrides
```

All hosts:
- Import `../..` (darwin base → common/ → shared modules)
- Set `system.stateVersion = 6`
- Import a selection of common modules (e.g., `antigravity-cli`, `opencode`, `gcloud-cli`)

---

## Host Comparison

### miraidon (Daily Driver MacBook)

| Aspect | Detail |
|---|---|
| **computerName** | `Miraidon` |
| **Togglable modules** | `calibre`, `colima`, `crush`, `powershell` |
| **Common modules** | `buku`, `copilot-cli`, `gcloud-cli`, `antigravity-cli`, `kubectl`, `opencode`, `xonsh` |
| **brew.masApps** | 1Password Safari, Compressor, Final Cut Pro, Logic Pro, Motion, Name Mangler 3, Pixelmator Pro, Xcode, Yoink |
| **brew.casks** | alfred, balenaetcher, chatgpt, claude, dash, discord, distroav, dolphin, firefox, freetube, google-chrome, google-drive, httpie-desktop, iina, imageoptim, krita, libndi, lm-studio, melonds, mgba-app, microsoft-edge, microsoft-remote-desktop, notion, notion-calendar, notion-mail, obs, obsidian, opera, plex, plexamp, pokemon-tcg-live, prismlauncher, slack, steam, tailscale-app, telegram, todoist-app, transmission, virtualbox, vivaldi, vlc, wave, xquartz, yaak, zen |
| **brew.brews** | imageoptim-cli, libyaml, sdl2, syncthing (restart_service) |
| **Extra packages** | cmake, chromedriver, ffmpeg |
| **Extra config** | nvim wakatime plugin overlay via `xdg.configFile` |

### comfey (Work Laptop — nclusion)

| Aspect | Detail |
|---|---|
| **computerName** | `Brooke's MacBook Pro` |
| **hostName** | `comfey` |
| **Togglable modules** | `colima.enable = false`, `crush`, `cursor`, `antigravity-cli`, `warp-terminal` |
| **Common modules** | `claude-code`, `codex`, `gcloud-cli`, `antigravity-cli`, `kubectl`, `opencode` |
| **brew.taps** | `withgraphite/homebrew-tap` |
| **brew.brews** | graphite |
| **brew.casks** | android-studio, claude, codex-app, conductor, dash, figma, google-chrome, linear, lm-studio, logi-options+, notion, notion-calendar, notion-mail, opencode-desktop, plexamp, slack, tailscale-app |
| **Git override** | Per-worktree git config for `gitdir:*/nclusion/` with nclusion email/name/signing key |
| **MCP servers** | figma, linear, notion |
| **Extra config** | `home.sessionPath` includes `~/.npm/bin` |

### xerneas (Secondary/Desktop Mac)

| Aspect | Detail |
|---|---|
| **computerName** | `Xerneas` |
| **Togglable modules** | `crush` |
| **Common modules** | `opencode` |
| **Darwin module** | `sikarugir` |
| **brew.casks** | discord, dolphin, google-drive, libndi, lm-studio, melonds, mgba-app, obs, plex, plexamp, pokemon-tcg-live, steam, tailscale-app, todoist-app |
| **brew.brews** | syncthing (restart_service) |
| **brew.masApps** | Same as miraidon (1Password Safari, Compressor, Final Cut Pro, Logic Pro, Motion, Name Mangler 3, Pixelmator Pro, Xcode, Yoink) |

---

## Adding a New Darwin Host

1. Create `nix/darwin/hosts/<name>/`
2. Add `default.nix` importing `./brew.nix`, `../..`, and selected common modules
3. Add `brew.nix` with per-host Homebrew config
4. Add the host to `flake.nix` darwinConfigurations mapping
5. Optional: add a `config/` directory for extra files (like miraidon's nvim plugin override)
