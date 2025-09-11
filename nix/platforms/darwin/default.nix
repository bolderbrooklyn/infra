{ config, ... }:
let
  username = config.common.username;
in
{
  imports = [
    ./home.nix
    ../common
    ../../modules/brew
    ../../modules/docker
    ../../modules/gui
    ../../modules/kubectl
    ../../modules/mise
    ../../modules/nushell
    ../../modules/powershell
    ../../modules/xonsh
  ];

  system.stateVersion = 6;

  system.primaryUser = username;

  nix.settings.trusted-users = [
    username
  ];

  programs.mise.enable = true;
  programs.powershell.enable = true;

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
}
