# `nix/common/modules/` — Shared Module Inventory

This directory contains 35 modules for cross-platform tools and applications.
All are **imported at compile time** by `nix/common/default.nix` (or selectively by
hosts); some toggle on/off via `brooklyn.programs.<name>.enable`, others are always
active.

---

## Module Inventory

### Togglable (`brooklyn.programs.<name>.enable`)

These modules only activate when a host enables them. Seven modules in this directory
define this pattern:

| Module | Option Path | Notes |
|---|---|---|
| `1password` | `brooklyn.programs._1password.enable` | Uses `isDarwin` special arg; SSH agent socket path differs per platform. `mkDefault true` on darwin hosts |
| `crush` | `brooklyn.programs.crush.enable` | Installs `llm-agents.crush`; inlines `crush.json` (just a `$schema` reference) into `xdg.configFile` |
| `antigravity-cli` | `brooklyn.programs.antigravity-cli.enable` | Writes a pre-baked `settings.json` (telemetry off, trusted workspace, scoped permissions) via HM activation to `~/.gemini/antigravity-cli/settings.json`. **Currently never enabled** — toggle is dead code, only the package import runs |
| `claude-code` | `brooklyn.programs.claude-code.enable` | — |
| `copilot-cli` | `brooklyn.programs.copilot-cli.enable` | Defined in `agent-instructions`; default `true`; writes shared instructions to `copilot-instructions.md` |
| `pi-coding-agent` | `brooklyn.programs.pi-coding-agent.enable` | Installs `llm-agents.pi` + `nodejs`/`bun` extra packages |
| `powershell` | `brooklyn.programs.powershell.enable` | `extraConfig` sub-option lets other modules (brew, starship) inject shellenv into PowerShell config |

### Per-Host Imports (no `brooklyn.programs.X.enable` toggle)

These modules are imported by individual hosts via their `imports` list and unconditionally
enable their HM program:

| Module | Imported By | Notes |
|---|---|---|
| `buku` | miraidon | — |
| `codex` | (none yet) | Orphan candidate — module exists but no host imports it |
| `docker` | (none yet) | Orphan candidate — module exists but no host imports it |
| `gcloud-cli` | miraidon, comfey | — |
| `kubectl` | miraidon, comfey | — |
| `opencode` | miraidon, xerneas, comfey, tinkaton | Has `brooklyn.programs.opencode.ohMyOpenAgentOverrides` (not an enable toggle) |
| `xonsh` | miraidon | — |

### Always-On (no toggle, globally imported)

Imported in `nix/common/default.nix` and active for every host.

**Unconditional** (always does something when imported):

| Module | What It Does |
|---|---|
| `agent-instructions` | Renders a single shared instructions string (fd/rg preference, workspace boundaries, secrets policy, network restrictions, commit format, etc.) into every enabled agent's global instruction file — `programs.<agent>.context` for `claude-code` / `codex` / `opencode` / `pi-coding-agent`, plus `xdg.configFile."<agent>/..."` for `crush` (`CRUSH.md`), `copilot-cli` (`copilot-instructions.md`), and `antigravity` (`GEMINI.md`, only when `antigravity-cli.enable` is true) |
| `bat` | `bat` as `cat` replacement with config |
| `btop` | System monitor |
| `catppuccin` | Catppuccin theming (system-wide with `autoEnable = true`; the NixOS base also sets `catppuccin.autoEnable` to suppress a warning) |
| `devenv` | Adds `pkgs.devenv` to home packages and a fish shell-init hook (`devenv hook fish \| source`) |
| `eza` | Modern `ls` replacement |
| `fd` | `find` replacement |
| `fzf` | Fuzzy finder; uses `${pkgs.fd}/bin/fd` for `defaultCommand` and `changeDirWidget.command` |
| `git` | Git + delta + gh + lazygit — SSH-signed commits, `trunk` default branch, `zdiff3` merge style |
| `mise` | `mise` with `node.compile = false` and `ruby.compile = false`, idiomatic-version-file for node + ruby |
| `nvim` | **Full Neovim config tree** (Lua files for lazy.nvim, LSP, treesitter, etc.) — `initLua` entry point |
| `openssh` | SSH client config |
| `rg` | ripgrep |
| `tmux` | tmux config (config/tmux/) |
| `yazi` | File manager |
| `zsh` | Zsh shell (enabled, not default) |

**Internally gated** (active only when an internal condition is true):

| Module | Gate | Notes |
|---|---|---|
| `fish` | `config.programs.fish.enable` | Set to `true` in `nix/common/default.nix` (default shell). With custom functions and vi key bindings |
| `gnupg` | `config.programs.gpg.enable` | Set to `true` inside the module itself |
| `nushell` | `config.programs.nushell.enable` | Set to `true` by miraidon. Module adds `nushell` to system `environment.systemPackages` and `environment.shells` |
| `starship` | `config.programs.starship.enable` | Set to `true` by HM. Also writes to `brooklyn.programs.powershell.extraConfig` when `powershell.enable` |

### Orphan

`superfile` exists in this directory but is not imported by `nix/common/default.nix` or
any host. Its `programs.superfile.enable = true` runs only if explicitly imported.

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
