{
  config,
  inputs,
  pkgs,
  ...
}:
let
  username = config.common.username;

  shells = with pkgs; [
    nushell
    xonsh
  ];
in
{
  imports = [
    ../common.nix
    inputs.home-manager.darwinModules.home-manager
    ./home.nix
    ../../modules/brew
    ../../modules/gui
    ../../modules/powershell
  ];

  environment.systemPackages = shells;
  environment.shells = shells;

  system.stateVersion = 6;

  system.primaryUser = username;

  nix.settings.trusted-users = [
    username
  ];

  programs.powershell.enable = true;

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
}
