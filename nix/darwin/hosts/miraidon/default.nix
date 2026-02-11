{ config, pkgs, ... }:
{
  imports = [
    ./brew.nix
    ../..
    ../../../common/modules/alacritty
    ../../../common/modules/buku
    ../../../common/modules/gcloud-cli
    ../../../common/modules/gemini-cli
    ../../../common/modules/ghostty
    ../../../common/modules/kitty
    ../../../common/modules/kubectl
    ../../../common/modules/nushell
    ../../../common/modules/opencode
    ../../../common/modules/xonsh
    ../../../common/modules/zed
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
