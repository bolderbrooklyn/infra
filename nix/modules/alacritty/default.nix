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

  homebrew.casks = lib.mkIf useCask [ "alacritty" ];

  home-manager.users.${config.common.username} = {
    programs.alacritty = {
      enable = true;
      package = if useCask then null else pkgs.alacritty;

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
