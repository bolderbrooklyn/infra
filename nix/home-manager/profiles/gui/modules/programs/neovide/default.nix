{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.brooklyn) font;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in
{
  options.brooklyn.programs.neovide.enable = lib.mkEnableOption "neovide";

  config = lib.mkIf config.brooklyn.programs.neovide.enable {
    home.shellAliases.nv = "neovide" + lib.optionalString isDarwin " --new-window --reuse-instance";

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
