{ config, ... }:
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

  nixpkgs = {
    overlays = [
      (_final: prev: {
        direnv = prev.direnv.overrideAttrs (_: {
          postPatch = ''
            substituteInPlace GNUmakefile --replace-fail " -linkmode=external" ""
          '';
        });
      })
    ];
  };

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
