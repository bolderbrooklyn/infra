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
    enableRosetta = false;
    user = config.common.username;
    mutableTaps = true;

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
      "mas"
      "mole"
      "pkpw"
    ];

    caskArgs.appdir = "~/Applications";
    casks = [
      "alt-tab"
      "pearcleaner"
      "the-unarchiver"
    ];

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
