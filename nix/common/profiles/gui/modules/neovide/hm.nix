{ config, lib, ... }:
let
  inherit (config.gui) font;
in
{
  options.brooklyn.programs.neovide.enable = lib.mkEnableOption "neovide";

  config = lib.mkIf config.brooklyn.programs.neovide.enable {
    home.shellAliases.nv = "neovide --reuse-instance --new-window";

    programs.neovide = {
      inherit (config.brooklyn.programs.neovide) enable;

      settings = {
        font = {
          inherit (font) size;
          normal = [ font.name ];
        };

        fork = true;
        srgb = true;
        title-hidden = true;
      };
    };
  };
}
