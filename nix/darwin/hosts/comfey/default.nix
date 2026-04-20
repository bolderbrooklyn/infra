{ config, ... }:
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
            path = ./config/git/nclusion.conf;
            condition = "gitdir:${config.home.homeDirectory}/Developer/Repositories/github.com/nclusion/";
          }
        ];

        mcp = {
          enable = true;
          servers = {
            figma.url = "http://127.0.0.1:3845/mcp";
            linear.url = "https://mcp.linear.app/mcp";
            notion.url = "https://mcp.notion.com/mcp";
          };
        };

        npm.enable = true;

        opencode.settings.plugin = [ "opencode-claude-auth" ];
      };

      xdg.configFile."nvim/lua/plugins/comfey.lua" = {
        source = ./config/nvim/lua/plugins/comfey.lua;
        force = true;
      };
    };
}
