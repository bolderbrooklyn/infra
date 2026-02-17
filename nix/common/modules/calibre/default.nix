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
  homebrew.casks = [ "calibre" ];
}
