{ config, ... }:
let
  username = config.common.username;
in
{
  imports = [
    ./home.nix
    ../common
    ../../modules/1password
    ../../modules/alacritty
    ../../modules/brew
    ../../modules/docker
    ../../modules/ghostty
    ../../modules/kubectl
    ../../modules/mise
    ../../modules/nushell
    ../../modules/powershell
    ../../modules/xonsh
    ../../modules/zed
  ];

  system.stateVersion = 6;

  system.primaryUser = username;

  nix.settings.trusted-users = [
    username
  ];

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
}
