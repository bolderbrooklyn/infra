{ config, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    ./home.nix
    ./modules/brew
    ./modules/colima
    ../common
    ../common/modules/1password
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
