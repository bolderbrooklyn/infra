{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../platforms/nixos
    ../../modules/crafty
    ../../modules/k3s
    ../../modules/ghostty
    ../../modules/plex
    ../../modules/postgresql
    ../../modules/servarr
    # ../../modules/tunarr
    ../../modules/unifi
  ];

  networking.hostName = "tinkaton";
  networking.firewall.allowedTCPPorts = [ 443 ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.linuxPackages_latest;
  };

  services = {
    xserver.enable = true;

    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    printing.enable = true;

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security.rtkit.enable = true;

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
