{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = config.common.username;
    mutableTaps = false;

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "jbhannah/homebrew-pkpw" = inputs.homebrew-pkpw;
    };
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;

    brews = [
      "colima"
      "gemini-cli"
      "lima-additional-guestagents"
      "mas"
      "pkpw"
    ];

    caskArgs.appdir = "~/Applications";
    casks = [
      "alt-tab"
      "arc"
      "dash"
      "google-chrome"
      "httpie-desktop"
      {
        name = "lm-studio";
        args.appdir = "/Applications";
      }
      "pearcleaner"
      "stats"
      "the-unarchiver"
      "visual-studio-code"
      "warp"
    ];

    masApps = {
      "1Password for Safari" = 1569813296;
      "Name Mangler 3" = 603637384;
      "Pixelmator Pro" = 1289583905;
      "Yoink" = 457622435;
    };

    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
  };

  home-manager.users.${config.common.username} = {
    imports = [
      ./aliases/brew.nix
    ];

    home.sessionVariables = {
      HOMEBREW_NO_ENV_HINTS = 1;
    };
  };

  programs.powershell.extraConfig = lib.mkIf config.programs.powershell.enable [
    "$(/opt/homebrew/bin/brew shellenv) | Invoke-Expression"
  ];
}
