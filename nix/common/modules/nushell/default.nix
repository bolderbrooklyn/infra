{ config, pkgs, ... }:
let
  nu = pkgs.nushell;
in
{
  environment.systemPackages = [ nu ];
  environment.shells = [ nu ];

  home-manager.users.${config.common.username} = {
    programs.nushell.enable = true;
  };
}
