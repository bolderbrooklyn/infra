{ config, pkgs, ... }:
let
  username = config.common.username;

  shells = with pkgs; [
    nushell
    xonsh
  ];
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
    ../../modules/powershell
  ];

  environment.systemPackages = shells;
  environment.shells = shells;

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
