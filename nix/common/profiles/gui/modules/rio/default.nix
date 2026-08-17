{ config, lib, ... }:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  imports = [ ../font ];

  options.brooklyn.programs.rio.enable = lib.mkEnableOption "rio";

  config = lib.mkIf config.brooklyn.programs.rio.enable {
    home-manager.users.${username} = {
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
  };
}
