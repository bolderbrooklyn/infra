{
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  imports = [
    ../font
    ../../../../modules/catppuccin
  ];

  options.brooklyn.programs.vscode.enable = lib.mkEnableOption "vscode";

  config = lib.mkIf config.brooklyn.programs.vscode.enable (
    {
      home-manager.users.${username} = lib.optionalAttrs isDarwin {
        targets.darwin.defaults = {
          "com.microsoft.VSCode" = {
            ApplePressAndHoldEnabled = false;
          };
        };
      };

      home-manager.sharedModules = [ ./hm.nix ];
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "visual-studio-code" ];
    }
  );
}
