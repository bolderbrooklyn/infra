{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  imports = [ ../font ];

  home-manager.users.${username} = {
    programs.ghostty = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.isDarwin null;
      installVimSyntax = !pkgs.stdenv.isDarwin;

      settings = {
        adjust-cell-height = "31%";
        background-blur = 64;
        background-opacity = 0.9;
        background-opacity-cells = true;
        clipboard-read = "allow";
        clipboard-write = "allow";
        font-family = font.name;
        font-size = font.size;
        fullscreen = pkgs.stdenv.isDarwin;
        quick-terminal-animation-duration = 0;
        window-inherit-working-directory = false;

        keybind = [
          "global:cmd+ctrl+backquote=toggle_quick_terminal"
        ];
      };
    };
  };

  homebrew = lib.optionalAttrs pkgs.stdenv.isDarwin {
    casks = [ "ghostty" ];
  };
}
