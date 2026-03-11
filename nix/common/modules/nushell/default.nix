{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs) nushell;
  inherit (config.common) username;
  inherit (config.home-manager.users.${username}.programs.nushell) enable;
in
lib.mkIf enable {
  environment.systemPackages = [ nushell ];
  environment.shells = [ nushell ];
}
