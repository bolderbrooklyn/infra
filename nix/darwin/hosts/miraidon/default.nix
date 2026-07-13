{ config, pkgs, ... }:
{
  imports = [
    ./brew.nix
    ../..
    ../../../common/modules/buku
    ../../../common/modules/copilot-cli
    ../../../common/modules/gcloud-cli
    ../../../common/modules/kubectl
    ../../../common/modules/opencode
    ../../../common/modules/xonsh
  ];

  system.stateVersion = 6;

  networking.computerName = "Miraidon";

  brooklyn.programs = {
    buku.enable = true;
    calibre.enable = true;
    colima.enable = true;
    copilot-cli.enable = true;
    crush.enable = true;
    gcloud-cli.enable = true;
    kubectl.enable = true;
    opencode.enable = true;
    powershell.enable = true;
    xonsh.enable = true;
  };

  services.openssh.enable = true;

  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      cmake
      chromedriver
      ffmpeg
    ];

    programs = {
      nushell.enable = true;

      opencode.settings.plugin = [ "opencode-wakatime@latest" ];
    };

    xdg.configFile."nvim/lua/plugins/wakatime.lua" = {
      source = ./config/nvim/lua/plugins/wakatime.lua;
      force = true;
    };
  };
}
