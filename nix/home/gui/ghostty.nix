{ config, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then null else pkgs.ghostty;
    installVimSyntax = config.programs.ghostty.package != null;

    settings = {
      adjust-cell-height = "15%";
      font-family = "Cascadia Code NF";
      font-size = 15;
      fullscreen = true;
      window-inherit-working-directory = false;
    };
  };
}
