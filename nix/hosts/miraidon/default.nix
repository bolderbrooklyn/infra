{ config, pkgs, ... }:
{
  imports = [
    ./brew.nix
    ../../platforms/darwin
    ../../modules/gcloud-cli
    ../../modules/kubectl
    ../../modules/nushell
    ../../modules/xonsh
  ];

  networking.hostName = "Miraidon";

  programs.powershell.enable = true;

  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      cmake
      chromedriver
      ffmpeg
    ];
  };
}
