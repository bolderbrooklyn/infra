{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
in
{
  home-manager.users.${username} = {
    programs.calibre = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.isDarwin null;
    };
  };

  homebrew = lib.optionalAttrs pkgs.stdenv.isDarwin {
    casks = [ "calibre" ];
  };
}
