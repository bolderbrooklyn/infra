{ config, pkgs, ... }:
{
  imports = [
    ./brew.nix
    ../..
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
    nushell.enable = true;
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

    programs.opencode.settings.plugin = [ "opencode-wakatime@latest" ];

    xdg.configFile."nvim/lua/plugins/wakatime.lua" = {
      source = ./config/nvim/lua/plugins/wakatime.lua;
      force = true;
    };
  };
}