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
{
  environment.systemPackages = lib.mkIf enable [ nushell ];
  environment.shells = lib.mkIf enable [ nushell ];
}
