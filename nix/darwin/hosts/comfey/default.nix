{ config, ... }:
let
  nclusionGit.contents = {
    user = {
      name = "brooke hannah";
      email = "bhannah@nclusion.com";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBm6eRCvtgFqySgOnt3gi9IMfGx5S026tEOuHV3BUbls";
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
    ../../../common/modules/antigravity-cli
    ../../../common/modules/kubectl
    ../../../common/modules/opencode
  ];

  system.stateVersion = 6;

  networking = {
    computerName = "Brooke's MacBook Pro";
    hostName = "comfey";
  };

  brooklyn.programs = {
    colima.enable = false;

    cursor = {
      enable = true;
      cli.enable = true;
    };

    antigravity-cli.enable = true;
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
            figma.url = "http://127.0.0.1:3845/mcp";
            linear.url = "https://mcp.linear.app/mcp";
            notion.url = "https://mcp.notion.com/mcp";
          };
        };

        opencode.settings.plugin = [ "opencode-claude-auth" ];
      };

      xdg.configFile."git/allowed_signers".text = ''
        ${nclusionGit.contents.user.email} ${nclusionGit.contents.user.signingKey}
      '';
    };
}
