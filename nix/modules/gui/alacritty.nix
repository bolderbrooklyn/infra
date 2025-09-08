{ config, pkgs, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.alacritty = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then null else pkgs.alacritty;

      settings = {
        font = {
          normal = {
            family = config.gui.font.name;
            style = "Regular";
          };
          size = config.gui.font.size;
          offset = {
            x = 0;
            y = 6;
          };
          glyph_offset = {
            x = 0;
            y = 2;
          };
        };
      };
    };
  };
}
