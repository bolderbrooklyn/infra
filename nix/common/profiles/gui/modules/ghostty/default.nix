{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
  inherit (config.gui) font;
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [ ../font ];

  options.brooklyn.programs.ghostty.enable = lib.mkEnableOption "ghostty";

  config = {
    home-manager.users.${username} = {
      programs.ghostty = {
        enable = config.brooklyn.programs.ghostty.enable;
        package = lib.mkIf isDarwin pkgs.ghostty-bin;
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
          macos-auto-secure-input = true;
          macos-icon = "custom-style";
          macos-icon-frame = "plastic";
          macos-icon-ghost-color = "#f5c2e7";
          macos-icon-screen-color = "#cba6f7,#f2cdcd";
          macos-option-as-alt = "left";
          split-inherit-working-directory = true;
          tab-inherit-working-directory = false;
          quick-terminal-animation-duration = 0;
          window-colorspace = "display-p3";
          window-inherit-working-directory = false;

          keybind = lib.mkIf isDarwin [
            "global:cmd+ctrl+backquote=toggle_quick_terminal"
          ];
        };
      };
    };
  };
}
