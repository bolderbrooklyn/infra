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
  home-manager.users.${config.common.username} = {
    programs.opencode = {
      enable = true;
      package = opencodePackage;

      rules = ./config/AGENTS.md;

      settings = {
        autoupdate = false;
        theme = "catppuccin";
        model = "google/gemini-3-pro-preview";

        keybinds = {
          input_submit = "super+return,return";
        };

        plugin = [
          "@tmegit/opencode-worktree-session@latest"
          "opencode-gemini-auth@latest"
          "opencode-wakatime@latest"
          "oh-my-opencode@latest"
        ];
      };
    };

    xdg.configFile."opencode/oh-my-opencode.json" = {
      source = ./config/oh-my-opencode.json;
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
