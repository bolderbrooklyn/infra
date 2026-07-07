# `nix/common/modules/` — Shared Module Inventory

This directory contains ~34 modules for cross-platform tools and applications.
All are **imported at compile time** by `nix/common/default.nix`; some toggle on/off via
`brooklyn.programs.<name>.enable`, others are always active.

---

## Module Inventory

### Togglable (`brooklyn.programs.<name>.enable`)

These modules only activate when a host enables them:

| Module | Option Path | Notes |
|---|---|---|
| `1password` | `brooklyn.programs._1password.enable` | Uses `isDarwin` special arg; SSH agent socket path differs per platform |
| `crush` | `brooklyn.programs.crush.enable` | Installs `llm-agents.crush`; inlines `crush.json` (just a `$schema` reference) into `xdg.configFile` |
| `devenv` | `brooklyn.programs.devenv.enable` | — |
| `antigravity-cli` | `brooklyn.programs.antigravity-cli.enable` | Writes a pre-baked `settings.json` (telemetry off, trusted workspace, scoped permissions) via HM activation to `~/.gemini/antigravity-cli/settings.json` |
| `claude-code` | `brooklyn.programs.claude-code.enable` | — |
| `codex` | `brooklyn.programs.codex.enable` | — |
| `opencode` | `brooklyn.programs.opencode.enable` | — |
| `buku` | `brooklyn.programs.buku.enable` | — |
| `copilot-cli` | `brooklyn.programs.copilot-cli.enable` | Default `true`; writes shared instructions to `copilot-instructions.md` |
| `docker` | `brooklyn.programs.docker.enable` | — |
| `gcloud-cli` | `brooklyn.programs.gcloud-cli.enable` | — |
| `kubectl` | `brooklyn.programs.kubectl.enable` | — |
| `nushell` | `brooklyn.programs.nushell.enable` | — |
| `powershell` | `brooklyn.programs.powershell.enable` | brew module injects extraConfig |
| `xonsh` | `brooklyn.programs.xonsh.enable` | — |

### Always-On (no toggle)

These modules are always active for every host:

| Module | What It Does |
|---|---|
| `agent-instructions` | Renders a single shared instructions string (fd/rg preference, workspace boundaries, secrets policy, network restrictions, commit format, etc.) into every enabled agent's global instruction file — `programs.<agent>.context` for `claude-code` / `codex` / `opencode`, plus `xdg.configFile."<agent>/..."` for `crush` (`CRUSH.md`), `copilot-cli` (`copilot-instructions.md`), and `antigravity` (`GEMINI.md`, only when `antigravity-cli.enable` is true) |
| `bat` | `bat` as `cat` replacement with config |
| `btop` | System monitor |
| `catppuccin` | Catppuccin theming (system-wide with `autoEnable = true`; the NixOS base also sets `catppuccin.autoEnable` to suppress a warning) |
| `eza` | Modern `ls` replacement |
| `fd` | `find` replacement |
| `fish` | Fish shell (default shell), with custom functions and vi key bindings |
| `fzf` | Fuzzy finder; uses `${pkgs.fd}/bin/fd` for `defaultCommand` and `changeDirWidget.command` |
| `git` | Git + delta + gh + lazygit — SSH-signed commits, `trunk` default branch, `zdiff3` merge style |
| `gnupg` | GPG config |
| `mise` | `mise` with `node.compile = false` and `ruby.compile = false`, idiomatic-version-file for node + ruby |
| `nvim` | **Full Neovim config tree** (Lua files for lazy.nvim, LSP, treesitter, etc.) — `initLua` entry point |
| `openssh` | SSH client config |
| `rg` | ripgrep |
| `starship` | Prompt |
| `superfile` | File manager (`programs.superfile.enable = true`) |
| `tmux` | tmux config (config/tmux/) |
| `yazi` | File manager |
| `zsh` | Zsh shell (enabled, not default) |

---

## Module Template

```nix
{ config, lib, pkgs, ... }:
{
  options.brooklyn.programs.<name>.enable = lib.mkEnableOption "<name>";

  config = lib.mkIf config.brooklyn.programs.<name>.enable {
    home-manager.users.${config.common.username} = {
      home.packages = with pkgs; [ <package> ];

      # xdg.configFile, home.sessionVariables, programs.<name>, etc.
    };
  };
}
```

Key patterns used in modules:
- `home-manager.users.${config.common.username}` — wraps all user-level config
- `xdg.configFile.<name>` — copies config directories
- `home.sessionVariables` — sets environment variables
- `home.packages` — installs packages
- `programs.<name>` — enables HM-managed programs
- `lib.mkIf pkgs.stdenv.isDarwin` — platform-conditional logic
- `lib.optionalAttrs` — conditionally adds attrs

Some modules (like `1password`) use the `isDarwin` special arg or `inputs` for flake inputs.

---

## Adding a New Module

1. Create `nix/common/modules/<name>/default.nix`
2. Follow the template above
3. Add `./modules/<name>` to the `imports` list in `nix/common/default.nix`
4. Enable it with `brooklyn.programs.<name>.enable = true` in the host's `default.nix`
5. If it doesn't need a toggle, just put config directly in the module (no `lib.mkIf`)
