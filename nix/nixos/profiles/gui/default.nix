{ config, pkgs, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    ../../../common/profiles/gui
  ];

  gui.font.size = 13;

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      kdePackages.kate
      wayclip
    ];
  };

  services = {
    xserver = {
      enable = true;

      xkb = {
        layout = "us";
        variant = "";
      };
    };

    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
