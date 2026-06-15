{
  imports = [
    ./brew.nix
    ../..
    ../../modules/sikarugir
    ../../../common/modules/opencode
  ];

  system.stateVersion = 6;

  networking.computerName = "Xerneas";
}
