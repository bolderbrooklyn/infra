{
  config,
  lib,
  isDarwin,
  ...
}:
let
  inherit (config.common) username;
in
with lib;
{
  home-manager.users.${username} = {
    programs.calibre = {
      enable = true;
      package = mkIf isDarwin null;
    };
  };
}
// optionalAttrs isDarwin {
  imports = [ ../../../darwin/modules/brew ];

  homebrew.casks = [ "calibre" ];
}
