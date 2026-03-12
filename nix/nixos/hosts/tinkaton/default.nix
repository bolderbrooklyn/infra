{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../..
    ../../profiles/gui
    ../../modules/audiobookshelf
    ../../modules/crafty
    ../../modules/forgejo
    ../../modules/jellyfin
    ../../modules/navidrome
    ../../modules/plex
    ../../modules/postgresql
    ../../modules/romm
    ../../modules/servarr
    ../../modules/syncthing
    ../../modules/tunarr
    ../../modules/unifi
    ../../../common/modules/openssh
  ];

  brooklyn.programs.calibre.enable = true;

  age.secrets = {
    romm.file = ./secrets/romm.age;
    "gitea-actions-runner-forgejo".file = ./secrets/gitea-actions-runner-forgejo.age;
    "gitea-actions-runner-codeberg".file = ./secrets/gitea-actions-runner-codeberg.age;
    "password-brooklyn".file = ./secrets/password-brooklyn.age;
  };

  networking = {
    hostName = "tinkaton";
    firewall.allowedTCPPorts = [
      443
      3389
    ];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  services = {
    cron = {
      enable = true;
      systemCronJobs = [
        "0 2 * * 1 root /run/current-system/sw/bin/systemctl reboot"
      ];
    };

    printing.enable = true;
  };

  security.rtkit.enable = true;

  users.users.${config.common.username} = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets."password-brooklyn".path;
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
