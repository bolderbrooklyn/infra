{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../platforms/nixos
    ../../modules/crafty
    ../../modules/ghostty
    ../../modules/plex
  ];

  networking.hostName = "tinkaton";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  gui.font.size = 13;

  users.users.${config.common.username} = {
    isNormalUser = true;
    description = "Brooklyn Hannah";
    hashedPassword = "$y$j9T$dXFtKCrUb27GthmYMAj/g0$6eOWmc92SNPNLadtqwC.g60JGua0HHoct7dmc/xulO/";
  };

  programs.firefox.enable = true;

  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      kdePackages.kate
      wayclip
    ];
  };

  system.stateVersion = "25.05";
}
