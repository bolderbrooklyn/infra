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
      "com.apple.finder" = {
        _FXSortFoldersFirst = true;
        _FXSortFoldersFirstOnDesktop = true;
        ShowStatusBar = true;
      };

      "com.apple.menuextra.clock" = {
        Show24Hour = true;
        ShowDate = 0;
      };

      "com.apple.safari" = {
        IncludeDevelopMenu = true;
      };

      "com.microsoft.VSCode" = {
        ApplePressAndHoldEnabled = false;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 25;
        KeyRepeat = 2;
      };
    };
  };
}
