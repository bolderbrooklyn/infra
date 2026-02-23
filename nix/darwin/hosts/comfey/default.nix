{
  imports = [
    ./brew.nix
    ../..
    ../../../common/profiles/gui
    ../../../common/modules/1password
  ];

  networking.hostName = "comfey";

  programs.git = {
    signingKey = {
      type = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBm6eRCvtgFqySgOnt3gi9IMfGx5S026tEOuHV3BUbls";
    };

    user = {
      name = "brooke hannah";
      email = "bhannah@nclusion.com";
    };
  };
}
