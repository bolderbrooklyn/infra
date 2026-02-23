{ config, pkgs, ... }:
{
  imports = [
    ./brew.nix
    ../..
    ../../modules/colima
    ../../../common/profiles/gui
    ../../../common/modules/1password
    ../../../common/modules/alacritty
    ../../../common/modules/buku
    ../../../common/modules/calibre
    ../../../common/modules/copilot-cli
    ../../../common/modules/crush
    ../../../common/modules/gcloud-cli
    ../../../common/modules/gemini-cli
    ../../../common/modules/kubectl
    ../../../common/modules/nushell
    ../../../common/modules/opencode
    ../../../common/modules/openssh
    ../../../common/modules/xonsh
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
