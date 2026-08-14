{ config, lib, ... }:
{
  options.brooklyn.programs.alacritty.enable = lib.mkEnableOption "alcritty";

  config = lib.mkIf config.brooklyn.programs.alacritty.enable {
    programs.alacritty = {
      inherit (config.brooklyn.programs.alacritty) enable;

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
