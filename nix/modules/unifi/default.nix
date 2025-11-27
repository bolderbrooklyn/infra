{ inputs, ... }:
let
  nixpkgs = import inputs.nixpkgs-mongodb-7_0_21 {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
    };
  };
in
{
  services.unifi = {
    enable = true;
    openFirewall = true;
    mongodbPackage = nixpkgs.mongodb-7_0;
  };
}
