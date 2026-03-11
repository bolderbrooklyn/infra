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
{
  imports = [ ../font ];

  options.brooklyn.programs.ghostty.enable = lib.mkEnableOption "ghostty";

  config = lib.mkIf config.brooklyn.programs.ghostty.enable (
    {
      home-manager.users.${username} = {
        programs.ghostty = {
          enable = true;
          package = lib.mkIf isDarwin null;
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
            quick-terminal-animation-duration = 0;
            window-inherit-working-directory = false;

            keybind = lib.mkIf isDarwin [
              "global:cmd+ctrl+backquote=toggle_quick_terminal"
            ];
          };
        };
      };
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "ghostty" ];
    }
  );
}
