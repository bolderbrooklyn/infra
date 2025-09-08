{ config, ... }:
{
  imports = [
    ./.
  ];

  home-manager.users.${config.common.username} =
    { pkgs, ... }:
    {
      imports = [
        ./aliases/darwin.nix
      ];

      xdg.configFile."powershell/Microsoft.PowerShell_profile.ps1" = {
        source = ../../dotfiles/.config/powershell/Microsoft.PowerShell_profile.ps1;
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
