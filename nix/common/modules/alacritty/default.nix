{ config, ... }:
{
  imports = [ ../font ];

  home-manager.users.${config.common.username} = {
    programs.alacritty = {
      enable = true;

      settings = {
        font = {
          inherit (config.gui.font) size;

          normal = {
            family = config.gui.font.name;
            style = "Regular";
          };
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
