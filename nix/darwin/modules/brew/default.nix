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
    mutableTaps = false;

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "jbhannah/homebrew-pkpw" = inputs.homebrew-pkpw;
    };

    trust.taps = [
      "jbhannah/pkpw"
    ];
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
      "arc"
      "pearcleaner"
      "the-unarchiver"
      "thebrowsercompany-dia"
    ];

    onActivation.upgrade = true;
  };

  home-manager.users.${config.common.username} = {
    imports = [
      ./aliases/brew.nix
    ];

    home.sessionVariables = {
      HOMEBREW_NO_ENV_HINTS = 1;
    };
  };

  brooklyn.programs.powershell.extraConfig = lib.mkIf config.brooklyn.programs.powershell.enable [
    "$(/opt/homebrew/bin/brew shellenv) | Invoke-Expression"
  ];
}
