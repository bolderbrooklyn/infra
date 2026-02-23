{ config, ... }:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  imports = [
    ../font
    ../nvim
  ];

  home-manager.users.${username} = {
    programs.neovide = {
      enable = true;

      settings = {
        font = {
          inherit (font) size;
          normal = [ font.name ];
        };

        fork = true;
        frame = "transparent";
        srgb = true;
        title-hidden = true;
      };
    };
  };
}
