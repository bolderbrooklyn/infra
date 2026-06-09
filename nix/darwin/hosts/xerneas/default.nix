{
  imports = [
    ./brew.nix
    ../..
  ];

  system.stateVersion = 6;

  networking = {
    computerName = "Xerneas";
    hostName = "xerneas";
  };

  brooklyn.programs = {
    _1password.enable = true;
  };
}
