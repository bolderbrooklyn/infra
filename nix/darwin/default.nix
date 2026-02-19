{ config, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    ./home.nix
    ./modules/brew
    ../common
  ];

  services.openssh.extraConfig = ''
    PasswordAuthentication no
    PermitRootLogin no
  '';

  system = {
    stateVersion = 6;
    primaryUser = username;
  };

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
}
