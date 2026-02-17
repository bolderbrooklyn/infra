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
        font = {
          inherit (font) size;
          normal = [ font.name ];
        };

        fork = true;
        frame = "none";
        srgb = true;
        title-hidden = true;
      };
    };
  };
}
// optionalAttrs isDarwin {
  homebrew.casks = [ "neovide" ];
}
