{
  imports = [
    ./brew.nix
    ../../platforms/darwin
  ];

  networking.hostName = "Miraidon";

  programs.powershell.enable = true;
}
