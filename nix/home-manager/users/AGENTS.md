# `nix/home-manager/users/` — Per-User Home-Manager Configs

User-scoped home-manager config. Each user directory:

- Lives under `users/<name>/default.nix`
- Imports the home-manager base (`../..`) so all global modules are loaded
- Sets per-user packages, shell aliases, syncthing device IDs, and which
  `brooklyn.programs.*.enable` toggles to flip on

Hosts pull in users by importing `../users/<name>` from
`nix/home-manager/hosts/<host>/default.nix`.

Currently one user:

| User | Hosts that use it | Role |
| --- | --- | --- |
| `brooklyn` | `archaludon` (via `hosts/archaludon/`) | Primary user — full CLI toolset + syncthing + GUI profile |

---

## brooklyn

### What `default.nix` Configures

- Imports `../..` (the home-manager base with all global modules)
- Sets `home.shellAliases.l = "ls -alh"` (also defined in
  `nix/common/home.nix`; per-user config wins)
- Installs `httpie` and `yq` as `home.packages`
- Defines the `brooklyn.{programs,services}` set used by every toggle
  module:

  ```nix
  brooklyn = {
    catppuccin.enable = true;

    programs = {
      bat.enable          = true;
      btop.enable         = true;
      crush.enable        = true;
      eza.enable          = true;
      fd.enable           = true;
      fish.enable         = true;
      fzf.enable          = true;
      ghostty.enable      = guiEnable;   # gated by brooklyn.gui.enable
      git.enable          = true;
      gnupg.enable        = true;
      neovide.enable      = guiEnable;   # gated by brooklyn.gui.enable
      nvim.enable         = true;
      obsidian.enable     = guiEnable;   # gated by brooklyn.gui.enable
      opencode.enable     = true;
      pi-coding-agent.enable = true;
      ripgrep.enable      = true;
      starship.enable     = true;
      television.enable   = true;
      tmux.enable         = true;
    };

    services.syncthing = {
      inherit devices;   # 6 devices: archaludon, frosmoth, kalmiya, miraidon, tinkaton, xerneas
      enable = true;
    };
  };

  programs = {
    devenv.enable = true;
    yazi.enable   = true;
    zoxide.enable = true;
  };
  ```

### Syncthing devices

Defined as a `let devices = { ... };` at the top of the file. The 6
device IDs are shared with `nix/nixos/modules/syncthing/default.nix` —
keep them in sync.

### Layering note

The `brooklyn` user also gets `nix/common/home.nix` applied (loaded via
`home-manager.sharedModules` from the platform base). That gives the user
`httpie`, `pkg-config`, agenix-rebuilt-against-Lix, `programs.ssh`, the
`l = "ls -alh"` alias, and `stateVersion = "26.05"` — *in addition to*
the per-user packages and toggles defined here.

---

## Adding a New User

1. Create `nix/home-manager/users/<name>/default.nix`
2. Import `../..` and configure `home.packages`, `brooklyn.programs.*`,
   `brooklyn.services.*`, etc.
3. Reference from one or more host configs in
   `nix/home-manager/hosts/<host>/default.nix`
4. Document the user here (add a row to the table and a subsection)
