{
  imports = [
    ./home.nix
  ];

  users.users.kalmiya = {
    isNormalUser = true;
    linger = true;
  };
}
