{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../platforms/nixos
    ../../modules/crafty
    ../../modules/forgejo
    ../../modules/ghostty
    ../../modules/plex
    ../../modules/postgresql
    ../../modules/romm
    ../../modules/servarr
    ../../modules/syncthing
    ../../modules/unifi
  ];

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 2 * * 1 root /run/current-system/sw/bin/systemctl reboot"
    ];
  };

  age.secrets.romm.file = ./secrets/romm.age;

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

  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      kdePackages.kate
      wayclip
    ];
  };

  services.syncthing.settings.folders = {
    "/mnt/genesect/emulation/library" = {
      id = "emulation";
      label = "Emulation";
      versioning.type = "staggered";
      ignorePerms = true;
      devices = [
        "archaludon"
        "frosmoth"
        "miraidon"
      ];
    };

    "/mnt/genesect/sync" = {
      id = "default";
      label = "Default";
      versioning.type = "staggered";
      ignorePerms = true;
      devices = [
        "archaludon"
        "frosmoth"
        "miraidon"
      ];
    };
  };

  fileSystems."/mnt/genesect/sync" = {
    device = "genesect.home.local:/nfs/Sync";
    fsType = "nfs";
  };

  fileSystems."/mnt/genesect/passport" = {
    device = "genesect.home.local:/nfs/Passport";
    fsType = "nfs";
  };

  system.stateVersion = "25.05";
}
