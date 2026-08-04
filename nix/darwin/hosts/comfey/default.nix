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
  ];

  system.stateVersion = 6;

  networking = {
    computerName = "Brooke's MacBook Pro";
    hostName = "comfey";
  };

  brooklyn.programs = {
    claude-code.enable = true;
    codex.enable = true;
    colima.enable = true;
    crush.enable = true;
    gcloud-cli.enable = true;
    kubectl.enable = true;
    opencode.enable = true;
    pi-coding-agent.enable = true;

    cursor = {
      enable = true;
      cli.enable = true;
    };

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
            figma.url = "https://mcp.figma.com/mcp";
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
