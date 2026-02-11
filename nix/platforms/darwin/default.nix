{ config, mac-app-util, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    mac-app-util.darwinModules.default
    ./home.nix
    ../common
    ../../modules/1password
    ../../modules/alacritty
    ../../modules/brew
    ../../modules/buku
    ../../modules/colima
    ../../modules/ghostty
    ../../modules/kitty
    ../../modules/zed
  ];

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
