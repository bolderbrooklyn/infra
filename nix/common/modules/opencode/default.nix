{
  config,
  lib,
  pkgs,
  ...
}:
let
  opencodePackage = pkgs.llm-agents.opencode;
in
{
  imports = [
    ../catppuccin
    ../../profiles/gui/modules/warp-terminal
  ];

  home-manager.users.${config.common.username} = {
    programs.opencode = {
      enable = true;
      package = opencodePackage;
      enableMcpIntegration = true;

      settings = {
        autoupdate = false;

        plugin = [
          "opencode-gemini-auth@latest"
          "oh-my-openagent@latest"
        ];
      };

      tui = {
        theme = lib.mkForce "catppuccin-mocha";
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
        ExecStart = "${opencodePackage}/bin/opencode serve --hostname 0.0.0.0 --port 4096 --cors https://opencode.anteater-wall.ts.net";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
