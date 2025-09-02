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
          source = ../../dotfiles/.config/ghostty/config;
        };

        ".config/powershell/Microsoft.PowerShell_profile.ps1" = {
          source = ../../dotfiles/.config/powershell/Microsoft.PowerShell_profile.ps1;
        };

        ".config/zed" = {
          source = ../../dotfiles/.config/zed;
          recursive = true;
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
        "com.apple.menuextra.clock" = {
          Show24Hour = true;
          ShowAMPM = false;
        };

        "com.microsoft.VSCode" = {
          ApplePressAndHoldEnabled = false;
        };
      };
    };
}
