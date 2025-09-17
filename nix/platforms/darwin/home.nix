{
  config,
  home-manager,
  pkgs,
  ...
}:
{
  imports = [
    home-manager.darwinModules.home-manager
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

    programs.gemini-cli = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then null else pkgs.gemini-cli;

      settings = {
        preferredEditor = "zed";
        selectedAuthType = "oauth-personal";
      };
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
