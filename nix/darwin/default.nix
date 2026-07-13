{ config, lib, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    ./home.nix
    ./modules/brew
    ./modules/colima
    ./modules/stats
    ../common
    ../common/profiles/gui
  ];

  nix.nixPath = [ ];

  brooklyn.programs._1password.enable = lib.mkDefault true;

  networking.hostName = lib.mkDefault (lib.strings.toLower config.networking.computerName);

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
