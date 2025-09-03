{ config, ... }:
{
  home-manager.users.${config.system.primaryUser} =
    { pkgs, ... }:
    {
      imports = [
        ./gui
        ./aliases/darwin.nix
      ];

      home.sessionVariables = {
        HOMEBREW_NO_ENV_HINTS = 1;
      };

      home.file = {
        ".config/powershell/Microsoft.PowerShell_profile.ps1" = {
          source = ../../dotfiles/.config/powershell/Microsoft.PowerShell_profile.ps1;
        };
      };

      home.packages = with pkgs; [
        fishPlugins.macos
        nil
        nixd
        nixfmt-rfc-style
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
