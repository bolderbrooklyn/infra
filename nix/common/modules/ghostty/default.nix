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
  imports = [ ../font ];

  home-manager.users.${username} = {
    programs.ghostty = {
      enable = true;
      package = mkIf isDarwin null;
      installVimSyntax = !isDarwin;

      settings = {
        adjust-cell-height = "28%";
        clipboard-read = "allow";
        clipboard-write = "allow";
        font-family = config.gui.font.name;
        font-size = config.gui.font.size;
        fullscreen = isDarwin;
        window-inherit-working-directory = false;
      };
    };
  };
}
// optionalAttrs isDarwin {
  homebrew.casks = [ "ghostty" ];
}
