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
  imports = [ ../font ];

  homebrew.casks = mkIf isDarwin [ "ghostty" ];

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
