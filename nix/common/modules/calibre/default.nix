{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
  inherit (pkgs.stdenv) isDarwin;
in
with lib;
{
  homebrew.casks = mkIf isDarwin [ "calibre" ];

  home-manager.users.${username} = {
    programs.calibre = {
      enable = true;
      package = mkIf isDarwin null;
    };

  };
}
