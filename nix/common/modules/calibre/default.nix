{
  config,
  lib,
  isDarwin,
  ...
}:
let
  inherit (config.common) username;
in
{
  home-manager.users.${username} = {
    programs.calibre = {
      enable = true;
      package = lib.mkIf isDarwin null;
    };
  };
}
// lib.optionalAttrs isDarwin {
  imports = [ ../../../darwin/modules/brew ];

  homebrew.casks = [ "calibre" ];
}
