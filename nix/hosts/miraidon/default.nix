{
  imports = [
    ./brew.nix
    ./home.nix
    ../../platforms/darwin
    ../../modules/kubectl
  ];

  networking.hostName = "Miraidon";
}
