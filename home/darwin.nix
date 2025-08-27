{ config, ... }:
{
  home-manager.users.${config.system.primaryUser} =
    { pkgs, ... }:
    {
      imports = [
        ./aliases/darwin.nix
      ];

      home.sessionVariables = {
        HOMEBREW_NO_ENV_HINTS = 1;
      };

      home.file = {
        ".config/ghostty/config" = {
          source = ./dotfiles/.config/ghostty/config;
        };

        ".config/opencode/opencode.jsonc" = {
          source = ./dotfiles/.config/opencode/opencode.jsonc;
        };

        ".config/powershell/Microsoft.PowerShell_profile.ps1" = {
          source = ./dotfiles/.config/powershell/Microsoft.PowerShell_profile.ps1;
        };
      };

      home.packages = with pkgs; [
        fishPlugins.macos
      ];

      services.macos-remap-keys = {
        enable = true;
        keyboard = {
          Capslock = "Control";
        };
      };

      targets.darwin.defaults = {
        "com.microsoft.VSCode" = {
          "ApplePressAndHoldEnabled" = false;
        };
      };
    };
}
