# `nix/home-manager/` — Home-Manager Module Inventory

Pure home-manager modules. **Every module is imported globally by
`nix/home-manager/default.nix`** and exposes a `brooklyn.programs.<name>.enable`
toggle. Users opt in or out via the toggle — no per-user module imports, no
commented imports.

Currently consumed by the standalone `archaludon.brooklyn` home-manager
configuration in `flake.nix`. The darwin/nixos hosts will be wired up to these
modules in a separate future task.

---

## Module Inventory

| Module | Option Path | Notes |
| --- | --- | --- |
| `agent-instructions` | *(no toggle — activates when any agent module is enabled)* | Renders shared instructions into every enabled agent's context file (claude-code, codex, opencode, pi-coding-agent) plus `crush/CRUSH.md`, `copilot/copilot-instructions.md`, `gemini/GEMINI.md` |
| `antigravity-cli` | `brooklyn.programs.antigravity-cli.enable` | Writes `settings.json` (telemetry off, trusted workspace) to `~/.gemini/antigravity-cli/`. **Currently never enabled** — dead toggle |
| `bat` | `brooklyn.programs.bat.enable` | `bat` as `cat` replacement |
| `btop` | `brooklyn.programs.btop.enable` | System monitor |
| `catppuccin` | `brooklyn.catppuccin.enable` | Catppuccin theming (system-wide with `autoEnable = true`) |
| `claude-code` | `brooklyn.programs.claude-code.enable` | Installs `llm-agents.claude-code` with MCP integration |
| `codex` | `brooklyn.programs.codex.enable` | No host currently enables it |
| `copilot-cli` | `brooklyn.programs.copilot-cli.enable` | Installs `llm-agents.copilot-cli` |
| `crush` | `brooklyn.programs.crush.enable` | Installs `llm-agents.crush` |
| `eza` | `brooklyn.programs.eza.enable` | Modern `ls` replacement |
| `fd` | `brooklyn.programs.fd.enable` | `find` replacement (also imported by `fzf`) |
| `fish` | `brooklyn.programs.fish.enable` | `fish` shell |
| `fzf` | `brooklyn.programs.fzf.enable` | Uses `${pkgs.fd}/bin/fd` for `defaultCommand` and `changeDirWidget.command` |
| `git` | `brooklyn.programs.git.enable` | Git + delta + gh + lazygit. Defines `programs.git.signingKey` and `programs.git.user` sub-options |
| `nvim` | `brooklyn.programs.nvim.enable` | **Full Neovim config tree** (Lua files for lazy.nvim, LSP, treesitter, etc.) — `initLua` entry point |
| `opencode` | `brooklyn.programs.opencode.enable` | Has `brooklyn.programs.opencode.ohMyOpenAgentOverrides` sub-option for per-host agent config |
| `pi-coding-agent` | `brooklyn.programs.pi-coding-agent.enable` | Installs `llm-agents.pi` + `nodejs`/`bun` extra packages |
| `ripgrep` | `brooklyn.programs.ripgrep.enable` | ripgrep (`rg`); renames `grep` shell alias. **Option name note**: directory is `rg/`, option is `ripgrep`, home-manager config is `programs.ripgrep` |
| `starship` | `brooklyn.programs.starship.enable` | Cross-shell prompt |
| `tmux` | `brooklyn.programs.tmux.enable` | tmux + tmux-powerline config |

---

## Module Template

```nix
{ config, lib, pkgs, ... }:
{
  options.brooklyn.programs.<name>.enable = lib.mkEnableOption "<name>";

  config = lib.mkIf config.brooklyn.programs.<name>.enable {
    home.packages = with pkgs; [ <package> ];

    # xdg.configFile, home.sessionVariables, programs.<name>, etc.
  };
}
```

Key patterns used in modules:

- `home.packages` — installs packages
- `xdg.configFile.<name>` — copies config files
- `home.sessionVariables` — sets environment variables
- `programs.<name>` — enables HM-managed programs
- `lib.mkIf pkgs.stdenv.isDarwin` — platform-conditional logic
- `lib.optionalAttrs` — conditionally adds attrs

---

## Adding a New Module

1. Create `nix/home-manager/modules/<name>/default.nix` (or `nix/home-manager/modules/programs/<name>/default.nix` for shell/CLI tools)
2. Follow the template above
3. Add the import to `nix/home-manager/default.nix` (top-level modules) or `nix/home-manager/modules/programs/default.nix` (program modules)
4. Users opt in with `brooklyn.programs.<name>.enable = true` or opt out with `false` in `nix/home-manager/users/<name>/default.nix`
