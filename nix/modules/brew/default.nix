{ config, inputs, ... }:
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
    };
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
  };

  home-manager.users.${config.common.username} = {
    imports = [
      ./aliases/brew.nix
    ];

    home.sessionVariables = {
      HOMEBREW_NO_ENV_HINTS = 1;
    };
  };
}
