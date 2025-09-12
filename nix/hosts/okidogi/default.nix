{
  imports = [
    ./brew.nix
    ./home.nix
    ../../platforms/darwin
  ];

  networking.hostName = "Okidogi";
  common.username = "bhannah";

  programs.git.user = {
    name = "Brooke Hannah";
    email = "bhannah@tvscientific.com";
  };
}
