{
  config,
  lib,
  pkgs,
  ...
}:
let
  useCask = pkgs.stdenv.isDarwin;
in
{
  imports = [ ../font ];

  home-manager.users.${config.common.username} = {
    programs.alacritty = {
      enable = true;
      package = lib.mkIf useCask null;

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
