{ config, lib, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    ../font
    ../../../../modules/bat
    ../../../../modules/catppuccin
  ];

  options.brooklyn.programs.kitty.enable = lib.mkEnableOption "kitty";

  config.home-manager.users.${username} = {
    programs.kitty = {
      inherit (config.brooklyn.programs.kitty) enable;
      inherit (config.gui) font;

      quickAccessTerminalConfig = {
        hide_on_focus_loss = true;
      };

      settings = {
        "modify_font cell_height" = "130%";
        scrollback_pager = "bat";
        scrollback_pager_history_size = 100;
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_bar_background = "none";
        background_opacity = 0.9;
        background_blur = 64;
        macos_option_as_alt = "left";
        macos_colorspace = "default";
        macos_titlebar_color = "background";
        macos_show_window_title_in = "menubar";
        wayland_titlebar_color = "background";
      };
    };
  };
}
