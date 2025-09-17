{
  imports = [
    ./brew.nix
    ../../platforms/darwin
    ../../modules/aerospace
  ];

  networking.hostName = "Miraidon";

  programs.powershell.enable = true;
}
