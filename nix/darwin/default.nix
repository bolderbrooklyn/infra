{ config, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    ./home.nix
    ./modules/brew
    ./modules/stats
    ../common
  ];

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };

  system = {
    defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    primaryUser = username;
  };
}
