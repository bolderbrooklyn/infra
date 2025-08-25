{ ... }:
{
  imports = [
    ../../.
    ../../modules/darwin.nix
  ];

  system.primaryUser = "bhannah";

  networking.hostName = "Okidogi";

  homebrew = {
    casks = [
      "slack"
    ];
  };

  system.stateVersion = 6;
}
