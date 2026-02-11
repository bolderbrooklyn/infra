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
  imports = [
    ../bat
    ../catppuccin
    ../font
  ];

  homebrew.casks = mkIf isDarwin [ "kitty" ];

  home-manager.users.${username} = {
    programs.kitty = {
      inherit (config.gui) font;

      enable = true;
      package = mkIf isDarwin null;

      settings = {
        "modify_font cell_height" = "130%";
        scrollback_pager = "bat";
        scrollback_pager_history_size = 100;
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        background_opacity = 0.97;
        macos_option_as_alt = "left";
        macos_colorspace = "default";
      };
    };
  };
}
