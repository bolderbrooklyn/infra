{
  config,
  pkgs,
  home-manager,
  ...
}:
let
  inherit (config.common) username;
in
{
  imports = [
    home-manager.darwinModules.home-manager
  ];

  home-manager.users.${username} = {
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
        minimize-to-application = true;
        show-recents = false;
        size-immutable = true;

        persistent-apps = [ ];
        persistent-others = [
          {
            tile-data = {
              arrangement = 2; # sort by date-added
              file-data = {
                _CFURLString = "file:///Users/${username}/Downloads";
                _CFURLStringType = 15;
              };
              file-label = "Downloads";
              showas = 1; # display as fan
            };
            tile-type = "directory-tile";
          }
        ];
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
        AutoFillCreditCardData = false;
        AutoFillPasswords = false;
        IncludeDevelopMenu = true;
      };

      "com.apple.screencapture" = {
        disable-shadow = true;
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
