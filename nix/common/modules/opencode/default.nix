{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  opencodePackage = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
in
{
  imports = [ ../catppuccin ];

  home-manager.users.${config.common.username} = {
    programs.opencode = {
      enable = true;
      package = opencodePackage;

      rules = ./config/AGENTS.md;

      settings = {
        autoupdate = false;

        keybinds = {
          input_submit = "super+return,return";
        };

        plugin = [
          "@tmegit/opencode-worktree-session@latest"
          "opencode-gemini-auth@latest"
          "oh-my-opencode@latest"
        ];
      };
    };
  }
  // lib.optionalAttrs pkgs.stdenv.isLinux {
    systemd.user.services.opencode-web = {
      Unit = {
        Description = "OpenCode web service";
        After = [ "network.target" ];
      };

      Service = {
        ExecStart = "${opencodePackage}/bin/opencode serve --hostname 0.0.0.0 --port 4096";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
