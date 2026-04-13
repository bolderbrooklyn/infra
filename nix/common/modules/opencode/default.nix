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
      context = ./config/AGENTS.md;
      enableMcpIntegration = true;

      settings = {
        autoupdate = false;

        plugin = [
          "@tmegit/opencode-worktree-session@latest"
          "opencode-gemini-auth@latest"
          "oh-my-opencode@latest"
        ];
      };

      tui = {
        theme = "catppuccin";
        keybinds = {
          input_submit = "super+return,return";
        };
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
