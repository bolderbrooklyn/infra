{
  config,
  agenix,
  catppuccin,
  home-manager,
  ...
}:
let
  inherit (config.common) username;
  defaultLocale = "en_US.UTF-8";
in
{
  imports = [
    agenix.nixosModules.default
    catppuccin.nixosModules.catppuccin
    home-manager.nixosModules.home-manager
    ../common
    ./modules/audiobookshelf
    ./modules/crafty
    ./modules/forgejo
    ./modules/jellyfin
    ./modules/k3s
    ./modules/kalmiya
    ./modules/lazylibrarian
    ./modules/media
    ./modules/navidrome
    ./modules/plex
    ./modules/podman
    ./modules/postgresql
    ./modules/romm
    ./modules/servarr
    ./modules/syncthing
    ./modules/tailscale
    ./modules/tunarr
    ./modules/unifi
    ./modules/unmanic
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
  };

  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    nftables.enable = true;
  };

  i18n = {
    inherit defaultLocale;

    extraLocaleSettings = {
      LC_ADDRESS = defaultLocale;
      LC_IDENTIFICATION = defaultLocale;
      LC_MEASUREMENT = defaultLocale;
      LC_MONETARY = defaultLocale;
      LC_NAME = defaultLocale;
      LC_NUMERIC = defaultLocale;
      LC_PAPER = defaultLocale;
      LC_TELEPHONE = defaultLocale;
      LC_TIME = defaultLocale;
    };
  };

  users = {
    mutableUsers = false;

    users.${username} = {
      uid = 1000;
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  services = {
    openssh.openFirewall = true;
    resolved.enable = true;
  };

  system.autoUpgrade = {
    enable = true;
    flake = "git+https://codeberg.org/bolderbrooklyn/infra#${config.networking.hostName}";
    persistent = true;
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };
}
