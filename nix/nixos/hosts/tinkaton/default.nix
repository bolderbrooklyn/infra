{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../..
    ../../profiles/gui
  ];

  brooklyn.programs = {
    calibre.enable = true;
    jellyfin.enable = false;
    k3s.enable = false;
    navidrome.enable = false;
    tunarr.enable = false;
    unifi.enable = false;
    unmanic.enable = false;
  };

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

    openssh.enable = true;
    printing.enable = true;
  };

  security.rtkit.enable = true;

  users.users.${config.common.username} = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets."password-brooklyn".path;
  };

  home-manager.users.${config.common.username} = {
    imports = [
      ../../../home-manager/users/brooklyn
    ];

    brooklyn.gui.enable = true;

    home.stateVersion = lib.mkForce "26.05";
    nix.package = lib.mkForce pkgs.lix;
    services.syncthing.enable = lib.mkForce false;
  };

  home-manager.useGlobalPkgs = lib.mkForce false;

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
        "xerneas"
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
        "xerneas"
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
