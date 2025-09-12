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

  homebrew.casks = lib.mkIf useCask [ "ghostty" ];

  home-manager.users.${config.common.username} = {
    programs.ghostty = {
      enable = true;
      package = if useCask then null else pkgs.ghostty;
      installVimSyntax = !useCask;

      settings = {
        adjust-cell-height = "15%";
        font-family = config.gui.font.name;
        font-size = config.gui.font.size;
        fullscreen = true;
        window-inherit-working-directory = false;
      };
    };
  };
}
