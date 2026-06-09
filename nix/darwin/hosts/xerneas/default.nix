{
  imports = [
    ./brew.nix
    ../..
    ../../../common/modules/opencode
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
