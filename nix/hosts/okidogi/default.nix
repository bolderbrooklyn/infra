{ ... }:
{
  imports = [
    ../../platforms/darwin.nix
  ];

  networking.hostName = "Okidogi";
  common.username = "bhannah";

  homebrew = {
    casks = [
      "keeper-password-manager"
      "slack"
    ];
  };
}
