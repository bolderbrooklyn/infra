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
    programs.neovide = {
      enable = true;
      package = mkIf isDarwin null;

      settings = {
        fork = true;
        font = {
          normal = [ config.gui.font.name ];
          size = 15.0;
        };
      };
    };
  };
}
// optionalAttrs isDarwin {
  homebrew.casks = [ "neovide" ];
}
