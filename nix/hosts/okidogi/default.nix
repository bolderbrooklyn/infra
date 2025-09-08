{ ... }:
{
  imports = [
    ../../.
    ../../platforms/darwin.nix
  ];

  networking.hostName = "Okidogi";
  system.primaryUser = "bhannah";

  homebrew = {
    casks = [
      "keeper-password-manager"
      "slack"
    ];
  };

  system.stateVersion = 6;
}
