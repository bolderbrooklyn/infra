# `nix/home-manager/` — Home-Manager Modules, Profiles, Hosts, and Users

Pure home-manager layer. **All modules are imported globally by
`nix/home-manager/default.nix`** and (except where noted) expose a
`brooklyn.programs.<name>.enable` toggle. Users opt in or out via the
toggle — no per-user module imports, no commented imports.

This layer is currently consumed only by the standalone
`archaludon.brooklyn` home-manager configuration in `flake.nix` (used by
the `frosmoth` Linux host). The NixOS and darwin hosts load their own
home-manager config via `nix/common/home.nix` and `nix/{darwin,nixos}/default.nix`
respectively, but those don't go through the modules in this directory —
they use the cross-platform `nix/common/modules/` and the per-platform
`nix/{darwin,nixos}/modules/` instead.

> See also:
>
> - [`./hosts/AGENTS.md`](hosts/AGENTS.md) — per-host HM configs (currently `archaludon`)
> - [`./users/AGENTS.md`](users/AGENTS.md) — per-user HM configs (currently `brooklyn`)
> - [`./profiles/gui/AGENTS.md`](profiles/gui/AGENTS.md) — GUI profile wrapping `ghostty`, `neovide`, `obsidian`

---

## Entry Points

| File | Purpose |
| --- | --- |
| `default.nix` | Defines `brooklyn.{username,homeDirectory}`, loads all modules/profiles, sets Lix + overlays, enables home-manager service + autoExpire |
| `modules/agent-instructions/default.nix` | Renders shared guardrails into each enabled agent's global context file |
| `modules/catppuccin/default.nix` | Catppuccin theming (`brooklyn.catppuccin.enable`, system-wide via `autoEnable = true`) |
| `modules/font/default.nix` | Default font options shared across home-manager GUI modules |
| `modules/programs/default.nix` | Imports every `programs/*` toggle module below |
| `modules/services/default.nix` | Imports every `services/*` toggle module below (currently `syncthing`) |
| `profiles/gui/default.nix` | Exposes `brooklyn.gui.enable`; wraps `profiles/gui/modules/programs/` |
| `hosts/<name>/default.nix` | Per-host HM config (e.g., `hosts/archaludon/`) |
| `users/<name>/default.nix` | Per-user HM config (e.g., `users/brooklyn/`) |

---

## Module Inventory

Modules live under `modules/programs/`, `modules/services/`, plus the
top-level `agent-instructions`, `catppuccin`, and `font` modules.

### `modules/programs/` (CLI/shell tools — `brooklyn.programs.<name>.enable`)

| Module | Option Path | Default | Notes |
| --- | --- | --- | --- |
| `bat` | `brooklyn.programs.bat.enable` | `false` | `bat` as `cat` replacement |
| `btop` | `brooklyn.programs.btop.enable` | `false` | System monitor |
| `buku` | `brooklyn.programs.buku.enable` | `false` | Bookmark manager |
| `claude-code` | `brooklyn.programs.claude-code.enable` | `false` | Installs `llm-agents.claude-code` with MCP integration |
| `codex` | `brooklyn.programs.codex.enable` | `false` | OpenAI Codex CLI (no host currently enables it) |
| `crush` | `brooklyn.programs.crush.enable` | `false` | Installs `llm-agents.crush` |
| `docker` | `brooklyn.programs.docker.enable` | `false` | Docker-related CLI packages |
| `eza` | `brooklyn.programs.eza.enable` | `false` | Modern `ls` replacement |
| `fd` | `brooklyn.programs.fd.enable` | `false` | `find` replacement (also imported by `fzf`) |
| `fish` | `brooklyn.programs.fish.enable` | `false` | `fish` shell |
| `fzf` | `brooklyn.programs.fzf.enable` | `false` | Uses `${pkgs.fd}/bin/fd` for `defaultCommand` and `changeDirWidget.command` |
| `gcloud-cli` | `brooklyn.programs.gcloud-cli.enable` | `false` | Google Cloud SDK + SQL proxy |
| `git` | `brooklyn.programs.git.enable` | `false` | Git + delta + gh + lazygit. Defines `programs.git.signingKey` and `programs.git.user` sub-options. On non-darwin GUI-enabled systems (NixOS hosts, standalone HM `archaludon`), also overrides `programs.git.package` with `pkgs.git.override { withLibsecret = true; }` and sets `credential.helper = "libsecret"` |
| `gnupg` | `brooklyn.programs.gnupg.enable` | `false` | GPG agent configuration |
| `kubectl` | `brooklyn.programs.kubectl.enable` | `false` | kubectl + helm + k9s + kubecolor |
| `mise` | `brooklyn.programs.mise.enable` | `false` | Version manager. Note: blocked by an HM option rename (`programs.mise.settings` → `programs.mise.globalConfig.settings`) |
| `nvim` | `brooklyn.programs.nvim.enable` | `false` | **Full Neovim config tree** (Lua files for lazy.nvim, LSP, treesitter, etc.) — `initLua` entry point |
| `opencode` | `brooklyn.programs.opencode.enable` | `false` | Has `brooklyn.programs.opencode.ohMyOpenAgentOverrides` sub-option for per-host agent config |
| `pi-coding-agent` | `brooklyn.programs.pi-coding-agent.enable` | `false` | Installs `llm-agents.pi` + `nodejs`/`bun` extra packages |
| `powershell` | `brooklyn.programs.powershell.enable` | `false` | `extraConfig` sub-option lets other modules inject shellenv |
| `ripgrep` | `brooklyn.programs.ripgrep.enable` | `false` | ripgrep (`rg`); renames `grep` shell alias. **Option name note**: directory is `rg/`, option is `ripgrep`, home-manager config is `programs.ripgrep` |
| `starship` | `brooklyn.programs.starship.enable` | `false` | Cross-shell prompt |
| `television` | `brooklyn.programs.television.enable` | `false` | Terminal fuzzy finder (TUI) |
| `tmux` | `brooklyn.programs.tmux.enable` | `false` | tmux + tmux-powerline config (jemalloc-enabled on Darwin) |

### `modules/services/`

| Module | Option Path | Default | Notes |
| --- | --- | --- | --- |
| `syncthing` | `brooklyn.services.syncthing.enable` | `false` | Full syncthing config: device IDs (6: archaludon, frosmoth, kalmiya, miraidon, tinkaton, xerneas), folder definitions, GUI settings. Toggle lives at `brooklyn.services.syncthing.enable` (not `brooklyn.programs.*`). |

### Top-level modules (different option namespaces)

| Module | Option Path | Notes |
| --- | --- | --- |
| `agent-instructions` | *(no toggle — activates when any agent module is enabled)* | Renders shared guardrails into every enabled agent's context file (`claude-code`, `codex`, `opencode`, `pi-coding-agent`) plus `crush/CRUSH.md`, `copilot/copilot-instructions.md`, `gemini/GEMINI.md` |
| `catppuccin` | `brooklyn.catppuccin.enable` | Catppuccin theming (system-wide via `autoEnable = true`) |
| `font` | `brooklyn.font` | Shared font defaults for GUI modules |

> The earlier AGENTS.md listed `antigravity-cli` and `copilot-cli` here, but
> no `programs/antigravity-cli/` or `programs/copilot-cli/` directory
> exists in the tree. The `agent-instructions` module still references an
> `antigravityEnabled` branch — see Anti-Patterns in the root AGENTS.md.

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

1. Create `nix/home-manager/modules/programs/<name>/default.nix` (or
   `nix/home-manager/modules/services/<name>/default.nix` for service-style
   modules like `syncthing`)
2. Follow the template above
3. Add the import to `nix/home-manager/modules/programs/default.nix` (or
   `modules/services/default.nix`)
4. Users opt in with `brooklyn.programs.<name>.enable = true` (or
   `brooklyn.services.<name>.enable` for services) in
   `nix/home-manager/users/<name>/default.nix`, or opt out with `false`

For top-level modules with a different option namespace (e.g.,
`catppuccin`), add the import directly to `nix/home-manager/default.nix`.
