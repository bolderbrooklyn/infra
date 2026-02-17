{
  config,
  lib,
  isDarwin,
  ...
}:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
with lib;
{
  imports = [ ../font ];

  home-manager.users.${username} = {
    programs.ghostty = {
      enable = true;
      package = mkIf isDarwin null;
      installVimSyntax = !isDarwin;

      settings = {
        adjust-cell-height = "31%";
        background-blur = 64;
        background-opacity = 0.9;
        background-opacity-cells = true;
        clipboard-read = "allow";
        clipboard-write = "allow";
        font-family = font.name;
        font-size = font.size;
        fullscreen = isDarwin;
        macos-non-native-fullscreen = true;
        quick-terminal-animation-duration = 0;
        window-inherit-working-directory = false;

        keybind = [
          "global:cmd+ctrl+backquote=toggle_quick_terminal"
        ];
      };
    };
  };
}
// optionalAttrs isDarwin {
  homebrew.casks = [ "ghostty" ];
}
