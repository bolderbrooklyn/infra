{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then null else pkgs.alacritty;

    settings = {
      font = {
        normal = {
          family = "Cascadia Code NF";
          style = "Regular";
        };
        size = 15.0;
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
