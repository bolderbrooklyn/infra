# `nix/common/modules/` — Shared Module Inventory

This directory contains cross-platform tools and applications. **Every module is
imported globally by `nix/common/default.nix`** and exposes a
`brooklyn.programs.<name>.enable` toggle. Hosts opt in or out via the toggle —
no per-host module imports, no commented imports.

The default for each toggle reflects whether the tool is useful for every host
in the grouping: `true` for lightweight universal tools, `false` for heavyweight
or niche ones (agent CLIs, SDKs, alternative shells).

---

## Module Inventory

| Module | Option Path | Default | Notes |
| --- | --- | --- | --- |
| `1password` | `brooklyn.programs._1password.enable` | `false` | Uses `isDarwin` special arg; SSH agent socket path differs per platform. `nix/darwin/default.nix` sets `lib.mkDefault true` so every darwin host gets it. |
| `agent-instructions` | `brooklyn.programs.agent-instructions.enable` | `true` | Renders shared instructions into every enabled agent's context file (claude-code, codex, opencode, pi-coding-agent) plus `crush/CRUSH.md`, `copilot/copilot-instructions.md`, `gemini/GEMINI.md` |
| `antigravity-cli` | `brooklyn.programs.antigravity-cli.enable` | `false` | Writes `settings.json` (telemetry off, trusted workspace) to `~/.gemini/antigravity-cli/`. **Currently never enabled** — dead toggle, only the package import runs |
| `bat` | `brooklyn.programs.bat.enable` | `true` | `bat` as `cat` replacement |
| `btop` | `brooklyn.programs.btop.enable` | `true` | System monitor |
| `buku` | `brooklyn.programs.buku.enable` | `false` | Bookmark manager |
| `catppuccin` | `brooklyn.programs.catppuccin.enable` | `true` | Catppuccin theming (system-wide with `autoEnable = true`) |
| `claude-code` | `brooklyn.programs.claude-code.enable` | `false` | Installs `llm-agents.claude-code` with MCP integration |
| `codex` | `brooklyn.programs.codex.enable` | `false` | No host currently enables it |
| `copilot-cli` | `brooklyn.programs.copilot-cli.enable` | `true` | Installs `llm-agents.copilot-cli` |
| `crush` | `brooklyn.programs.crush.enable` | `false` | Installs `llm-agents.crush` |
| `devenv` | `brooklyn.programs.devenv.enable` | `true` | `pkgs.devenv` + fish shell-init hook |
| `docker` | `brooklyn.programs.docker.enable` | `true` | Docker packages for home-manager |
| `eza` | `brooklyn.programs.eza.enable` | `true` | Modern `ls` replacement |
| `fd` | `brooklyn.programs.fd.enable` | `true` | `find` replacement (also imported by `fzf`) |
| `fish` | `brooklyn.programs.fish.enable` | `true` | Custom functions, vi key bindings; `programs.fish.defaultShell = true` makes it the default shell |
| `fzf` | `brooklyn.programs.fzf.enable` | `true` | Uses `${pkgs.fd}/bin/fd` for `defaultCommand` and `changeDirWidget.command` |
| `gcloud-cli` | `brooklyn.programs.gcloud-cli.enable` | `false` | Google Cloud SDK + SQL proxy |
| `git` | `brooklyn.programs.git.enable` | `true` | Git + delta + gh + lazygit. Defines `programs.git.signingKey` and `programs.git.user` sub-options |
| `gnupg` | `brooklyn.programs.gnupg.enable` | `true` | GPG agent with `pinentry_mac` on darwin |
| `kubectl` | `brooklyn.programs.kubectl.enable` | `false` | kubectl + helm + k9s + kubecolor |
| `mise` | `brooklyn.programs.mise.enable` | `true` | Version manager. Note: blocked by an HM option rename (`programs.mise.settings` → `programs.mise.globalConfig.settings`) |
| `nvim` | `brooklyn.programs.nvim.enable` | `true` | **Full Neovim config tree** (Lua files for lazy.nvim, LSP, treesitter, etc.) — `initLua` entry point |
| `nushell` | `brooklyn.programs.nushell.enable` | `false` | Adds nushell to `environment.systemPackages` and `environment.shells` |
| `opencode` | `brooklyn.programs.opencode.enable` | `false` | Has `brooklyn.programs.opencode.ohMyOpenAgentOverrides` sub-option for per-host agent config |
| `openssh` | `brooklyn.programs.openssh.enable` | `true` | Adds `services.openssh.extraConfig` (`PasswordAuthentication no`, `PermitRootLogin no`) |
| `pi-coding-agent` | `brooklyn.programs.pi-coding-agent.enable` | `false` | Installs `llm-agents.pi` + `nodejs`/`bun` extra packages |
| `powershell` | `brooklyn.programs.powershell.enable` | `false` | `extraConfig` sub-option lets other modules (brew, starship) inject shellenv into PowerShell config |
| `ripgrep` | `brooklyn.programs.ripgrep.enable` | `true` | ripgrep (`rg`); renames `grep` shell alias. **Option name note**: directory is `rg/`, option is `ripgrep`, home-manager config is `programs.ripgrep` |
| `starship` | `brooklyn.programs.starship.enable` | `true` | Cross-shell prompt. Writes starship init to `powershell.extraConfig` when powershell is enabled |
| `tmux` | `brooklyn.programs.tmux.enable` | `true` | tmux + tmux-powerline config |
| `xonsh` | `brooklyn.programs.xonsh.enable` | `false` | Adds xonsh to `environment.systemPackages` and `environment.shells` |
| `yazi` | `brooklyn.programs.yazi.enable` | `true` | File manager |
| `zsh` | `brooklyn.programs.zsh.enable` | `true` | Zsh shell (enabled, not default) |

---

## Module Template

```nix
{ config, lib, pkgs, ... }:
{
  options.brooklyn.programs.<name>.enable = lib.mkEnableOption "<name>" // {
    default = true;  # false if heavyweight / niche
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
2. Follow the template above (`default = true` for universal tools, `false` for niche ones)
3. Add `./modules/<name>` to the `imports` list in `nix/common/default.nix` — this is automatic for every module
4. Hosts opt in with `brooklyn.programs.<name>.enable = true` or opt out with `false`