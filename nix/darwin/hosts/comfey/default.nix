{ config, ... }:
let
  nclusionGit.contents = {
    signingKey = {
      type = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBm6eRCvtgFqySgOnt3gi9IMfGx5S026tEOuHV3BUbls";
    };

    user = {
      name = "brooke hannah";
      email = "bhannah@nclusion.com";
    };
  };
in
{
  imports = [
    ./brew.nix
    ../..
    ../../../common/modules/claude-code
    ../../../common/modules/codex
    ../../../common/modules/gcloud-cli
    ../../../common/modules/gemini-cli
    ../../../common/modules/kubectl
    ../../../common/modules/opencode
  ];

  system.stateVersion = 6;

  networking = {
    computerName = "Brooke's MacBook Pro";
    hostName = "comfey";
  };

  brooklyn.programs = {
    _1password.enable = true;
    colima.enable = true;

    cursor = {
      enable = true;
      cli.enable = true;
    };

    gemini-cli.enable = true;
    warp-terminal.enable = true;
  };

  home-manager.users.${config.common.username} =
    { config, ... }:
    {
      home.sessionPath = [ "${config.home.homeDirectory}/.npm/bin" ];

      programs = {
        git.includes = [
          {
            inherit (nclusionGit) contents;
            condition = "gitdir:${config.home.homeDirectory}/Developer/Repositories/github.com/nclusion/";
          }
        ];

        mcp = {
          enable = true;
          servers = {
            linear.url = "https://mcp.linear.app/mcp";
            notion.url = "https://mcp.notion.com/mcp";
          };
        };

        opencode.settings.plugin = [ "opencode-claude-auth" ];
        qutebrowser.enable = true;
      };

      xdg.configFile."nvim/lua/plugins/comfey.lua" = {
        source = ./config/nvim/lua/plugins/comfey.lua;
        force = true;
      };
    };
}
