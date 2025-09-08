{ ... }:
{
  imports = [
    ../../platforms/darwin.nix
  ];

  networking.hostName = "Okidogi";
  common.username = "bhannah";

  programs.git.user = {
    name = "Brooke Hannah";
    email = "bhannah@tvscientific.com";
  };

  homebrew = {
    casks = [
      "keeper-password-manager"
      "slack"
    ];
  };
}
