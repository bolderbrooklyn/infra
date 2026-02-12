{
  config,
  agenix,
  home-manager,
  ...
}:
let
  inherit (config.common) username;
in
{
  imports = [
    agenix.nixosModules.default
    home-manager.nixosModules.home-manager
    ./modules/tailscale
    ../common
  ];

  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    nftables.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
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

  programs.nix-ld.enable = true;

  services = {
    openssh = {
      openFirewall = true;

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

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
