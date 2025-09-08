{ config, inputs, ... }:
let
  username = config.common.username;
in
{
  imports = [
    ./common.nix
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ../home/default.nix
  ];

  networking.networkmanager.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";

  users.mutableUsers = false;

  users.users.${username} = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
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

  system.autoUpgrade = {
    enable = true;
    flake = "github:jbhannah/infra";
    persistent = true;
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };
}
