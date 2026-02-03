{
  config,
  inputs,
  home-manager,
  ...
}:
let
  inherit (config.common) username;
in
{
  imports = [
    home-manager.nixosModules.home-manager
    ../common
    ../../modules/tailscale
  ];

  environment.systemPackages = [
    inputs.agenix.packages.${config.nixpkgs.hostPlatform.system}.default
  ];

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  networking.nftables.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  users.mutableUsers = false;

  users.users.${username} = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.nix-ld.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.resolved.enable = true;

  system.autoUpgrade = {
    enable = true;
    flake = "github:jbhannah/infra#${config.networking.hostName}";
    persistent = true;
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };
}
