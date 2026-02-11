{ config, ... }:
{
  imports = [
    ../bat
    ../catppuccin
    ../font
  ];

  home-manager.users.${config.common.username} = {
    programs.kitty = {
      inherit (config.gui) font;

      enable = true;

      settings = {
        "modify_font cell_height" = "130%";
        scrollback_pager = "bat";
        scrollback_pager_history_size = 100;
        background_opacity = 0.97;
        macos_option_as_alt = "left";
        macos_colorspace = "default";
      };
    };
  };
}
