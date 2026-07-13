# `nix/common/modules/` — Shared Module Inventory

This directory contains 35 modules for cross-platform tools and applications.
All are **imported at compile time** by `nix/common/default.nix` (or selectively by
hosts); every module now follows the `brooklyn.programs.<name>.enable` toggle pattern.
Modules default to **on** when globally imported (preserving prior behavior) and **off**
when imported by individual hosts.

---

## Module Inventory

### Togglable (`brooklyn.programs.<name>.enable`)

All modules in this directory define this pattern. Default behavior depends on where the
module is imported from:

- **Globally imported** (in `nix/common/default.nix`) — `default = true`, so behavior is
  preserved unless a host overrides.
- **Per-host imported** (in a host's `default.nix`) — `default = false`; the importing
  host sets `brooklyn.programs.<name>.enable = true` explicitly.

| Module | Option Path | Default | Imported From | Notes |
| --- | --- | --- | --- | --- |
| `1password` | `brooklyn.programs._1password.enable` | `false` | `nix/darwin/default.nix` (`lib.mkDefault true`) | Uses `isDarwin` special arg; SSH agent socket path differs per platform |
| `agent-instructions` | `brooklyn.programs.agent-instructions.enable` | `true` | global | Renders shared instructions into every enabled agent's context file (claude-code, codex, opencode, pi-coding-agent) plus `crush/CRUSH.md`, `copilot/copilot-instructions.md`, `gemini/GEMINI.md` |
| `antigravity-cli` | `brooklyn.programs.antigravity-cli.enable` | `false` | global | Writes `settings.json` (telemetry off, trusted workspace) to `~/.gemini/antigravity-cli/`. **Currently never enabled** — toggle is dead code, only the package import runs |
| `bat` | `brooklyn.programs.bat.enable` | `true` | global | `bat` as `cat` replacement |
| `btop` | `brooklyn.programs.btop.enable` | `true` | global | System monitor |
| `buku` | `brooklyn.programs.buku.enable` | `false` | miraidon | Bookmark manager |
| `catppuccin` | `brooklyn.programs.catppuccin.enable` | `true` | global | Catppuccin theming (system-wide with `autoEnable = true`) |
| `claude-code` | `brooklyn.programs.claude-code.enable` | `false` | comfey | Installs `llm-agents.claude-code` with MCP integration |
| `codex` | `brooklyn.programs.codex.enable` | `false` | (orphan) | No host currently imports it |
| `copilot-cli` | `brooklyn.programs.copilot-cli.enable` | `true` | miraidon | Installs `llm-agents.copilot-cli`. Option only defined when module is imported |
| `crush` | `brooklyn.programs.crush.enable` | `false` | miraidon, xerneas, comfey, tinkaton | Installs `llm-agents.crush` |
| `devenv` | `brooklyn.programs.devenv.enable` | `true` | global | `pkgs.devenv` + fish shell-init hook |
| `docker` | `brooklyn.programs.docker.enable` | `true` | colima (darwin-only) | Docker packages for home-manager. Auto-enabled because colima imports it on every darwin host |
| `eza` | `brooklyn.programs.eza.enable` | `true` | global | Modern `ls` replacement |
| `fd` | `brooklyn.programs.fd.enable` | `true` | global | `find` replacement (also imported by `fzf`) |
| `fish` | `brooklyn.programs.fish.enable` | `true` | global | Custom functions, vi key bindings; `programs.fish.defaultShell = true` makes it the default shell |
| `fzf` | `brooklyn.programs.fzf.enable` | `true` | global | Uses `${pkgs.fd}/bin/fd` for `defaultCommand` and `changeDirWidget.command` |
| `gcloud-cli` | `brooklyn.programs.gcloud-cli.enable` | `false` | miraidon, comfey | Google Cloud SDK + SQL proxy |
| `git` | `brooklyn.programs.git.enable` | `true` | global | Git + delta + gh + lazygit. Defines `programs.git.signingKey` and `programs.git.user` sub-options |
| `gnupg` | `brooklyn.programs.gnupg.enable` | `true` | global | GPG agent with `pinentry_mac` on darwin |
| `kubectl` | `brooklyn.programs.kubectl.enable` | `false` | miraidon, comfey | kubectl + helm + k9s + kubecolor |
| `mise` | `brooklyn.programs.mise.enable` | `true` | (orphan) | Module exists but is not imported anywhere. **Pre-existing inconsistency**: AGENTS.md says always-on but the imports list omits it. Also blocked by an HM option rename (`programs.mise.settings` → `programs.mise.globalConfig.settings`) |
| `nvim` | `brooklyn.programs.nvim.enable` | `true` | global | **Full Neovim config tree** (Lua files for lazy.nvim, LSP, treesitter, etc.) — `initLua` entry point |
| `nushell` | (none) | n/a | miraidon | Reads `programs.nushell.enable`; not following the `brooklyn.programs.*` toggle convention (gated by HM's `programs.nushell.enable`) |
| `opencode` | `brooklyn.programs.opencode.enable` | `false` | miraidon, xerneas, comfey, tinkaton | Has `brooklyn.programs.opencode.ohMyOpenAgentOverrides` sub-option for per-host agent config |
| `openssh` | `brooklyn.programs.openssh.enable` | `true` | global | Adds `services.openssh.extraConfig` (`PasswordAuthentication no`, `PermitRootLogin no`) |
| `pi-coding-agent` | `brooklyn.programs.pi-coding-agent.enable` | `false` | comfey, xerneas | Installs `llm-agents.pi` + `nodejs`/`bun` extra packages |
| `powershell` | `brooklyn.programs.powershell.enable` | `false` | miraidon | `extraConfig` sub-option lets other modules (brew, starship) inject shellenv into PowerShell config |
| `ripgrep` | `brooklyn.programs.ripgrep.enable` | `true` | global | ripgrep (`rg`); renames `grep` shell alias |
| `starship` | `brooklyn.programs.starship.enable` | `true` | global | Cross-shell prompt. Writes starship init to `powershell.extraConfig` when powershell is enabled |
| `tmux` | `brooklyn.programs.tmux.enable` | `true` | global | tmux + tmux-powerline config |
| `xonsh` | `brooklyn.programs.xonsh.enable` | `false` | miraidon | Adds xonsh to `environment.systemPackages` and `environment.shells` |
| `yazi` | `brooklyn.programs.yazi.enable` | `true` | global | File manager |
| `zsh` | `brooklyn.programs.zsh.enable` | `true` | global | Zsh shell (enabled, not default) |

### Orphan

`superfile` exists in this directory but is not imported by `nix/common/default.nix` or
any host. Its `programs.superfile.enable = true` runs only if explicitly imported.

---

## Module Template

```nix
{ config, lib, pkgs, ... }:
{
  options.brooklyn.programs.<name>.enable = lib.mkEnableOption "<name>" // {
    default = true; # false if per-host imported
  };

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
2. Follow the template above (with `default = false` if it should be per-host)
3. Add `./modules/<name>` to the `imports` list in `nix/common/default.nix` (for globally imported) or to the host's `default.nix` (for per-host)
4. If globally imported with `default = true`, no further action — it just works
5. If per-host imported, enable it with `brooklyn.programs.<name>.enable = true` in the host's `default.nix`
