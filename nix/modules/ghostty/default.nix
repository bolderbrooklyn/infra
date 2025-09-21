{
  config,
  pkgs,
  ...
}:
let
  useCask = pkgs.stdenv.isDarwin;
in
{
  imports = [ ../font ];

  home-manager.users.${config.common.username} = {
    programs.ghostty = {
      enable = true;
      package = if useCask then null else pkgs.ghostty;
      installVimSyntax = !useCask;

      settings = {
        adjust-cell-height = "28%";
        clipboard-read = "allow";
        clipboard-write = "allow";
        font-family = config.gui.font.name;
        font-size = config.gui.font.size;
        fullscreen = useCask;
        window-inherit-working-directory = false;
      };
    };
  };
}
