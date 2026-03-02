{ config, ... }:
{
  imports = [
    ./brew.nix
    ../..
    ../../modules/colima
    ../../../common/profiles/gui
    ../../../common/modules/1password
    ../../../common/modules/codex
    ../../../common/modules/cursor
    ../../../common/modules/gcloud-cli
    ../../../common/modules/opencode
    ../../../common/modules/vscode
  ];

  networking = {
    computerName = "Brooke's MacBook Pro";
    hostName = "comfey";
  };

  programs.cursor = {
    enable = true;
    cli.enable = true;
  };

  programs.git = {
    signingKey = {
      type = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBm6eRCvtgFqySgOnt3gi9IMfGx5S026tEOuHV3BUbls";
    };

    user = {
      name = "brooke hannah";
      email = "bhannah@nclusion.com";
    };
  };

  home-manager.users.${config.common.username} = {
    xdg.configFile."nvim/lua/plugins/comfey.lua" = {
      source = ./config/nvim/lua/plugins/comfey.lua;
      force = true;
    };
  };
}
