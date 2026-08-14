{ config, lib, ... }:
let
  inherit (config.gui) font;
in
{
  options.brooklyn.programs.rio.enable = lib.mkEnableOption "rio";

  config = lib.mkIf config.brooklyn.programs.rio.enable {
    programs.rio = {
      enable = true;

      settings = {
        fonts = {
          inherit (font) size;
          family = font.name;
          use-drawable-chars = true;
        };
        line-height = 1.3;
      };
    };
  };
}
