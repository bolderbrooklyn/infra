{ config, lib, ... }:
let
  inherit (config.brooklyn) font;
in
{
  options.brooklyn.programs.alacritty.enable = lib.mkEnableOption "alcritty";

  config.programs.alacritty = {
    inherit (config.brooklyn.programs.alacritty) enable;

    settings = {
      font = {
        inherit (font) size;

        normal = {
          family = font.name;
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
}
