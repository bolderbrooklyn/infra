{ config, pkgs, ... }:
let
  cfg = config;
in
{
  home-manager.users.${cfg.common.username} =
    { config, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = if pkgs.stdenv.isDarwin then null else pkgs.ghostty;
        installVimSyntax = config.programs.ghostty.package != null;

        settings = {
          adjust-cell-height = "15%";
          font-family = cfg.gui.font.name;
          font-size = cfg.gui.font.size;
          fullscreen = true;
          window-inherit-working-directory = false;
        };
      };
    };
}
