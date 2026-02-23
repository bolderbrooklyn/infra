{
  config,
  pkgs,
  home-manager,
  ...
}:
{
  imports = [
    home-manager.darwinModules.home-manager
  ];

  home-manager.users.${config.common.username} = {
    home = {
      shellAliases = {
        pbc = "pbcopy";
        pbp = "pbpaste";
      };
    };

    programs.man.package = pkgs.man;

    services.macos-remap-keys = {
      enable = true;
      keyboard = {
        Capslock = "Control";
      };
    };

    targets.darwin.defaults = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };

      "com.apple.dock" = {
        autohide = true;
        size-immutable = true;
      };

      "com.apple.finder" = {
        _FXSortFoldersFirst = true;
        _FXSortFoldersFirstOnDesktop = true;
        ShowStatusBar = true;
      };

      "com.apple.menuextra.clock" = {
        Show24Hour = true;
        ShowAMPM = false;
        ShowDate = 0;
      };

      "com.apple.safari" = {
        IncludeDevelopMenu = true;
      };

      "com.microsoft.VSCode" = {
        ApplePressAndHoldEnabled = false;
      };

      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        AppleShowScrollBars = "WhenScrolling";
        InitialKeyRepeat = 25;
        KeyRepeat = 2;
      };
    };
  };
}
