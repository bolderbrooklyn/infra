{ inputs, pkgs, ... }:
let
  nixpkgs-mongodb-7_0_21 = import inputs.nixpkgs-mongodb-7_0_21 {
    inherit (pkgs.stdenv.hostPlatform) system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  services.unifi = {
    enable = true;
    openFirewall = true;
    mongodbPackage = nixpkgs-mongodb-7_0_21.mongodb-7_0;
  };
}
