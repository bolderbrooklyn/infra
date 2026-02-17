{
  config,
  lib,
  isDarwin,
  ...
}:
let
  inherit (config.common) username;
  inherit (config.gui) font;
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
          inherit (font) size;
          normal = [ font.name ];
        };
      };
    };
  };
}
// optionalAttrs isDarwin {
  homebrew.casks = [ "neovide" ];
}
