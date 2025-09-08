{ config, pkgs, ... }:
{
  imports = [
    ../../home
  ];

  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      nil
      nixd
      nixfmt-rfc-style
    ];

    home.shellAliases = {
      pbc = "pbcopy";
      pbp = "pbpaste";
    };

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
