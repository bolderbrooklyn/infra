{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  nixpkgs-mongodb-7_0_21 = import inputs.nixpkgs-mongodb-7_0_21 {
    inherit (pkgs.stdenv.hostPlatform) system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  options.brooklyn.programs.unifi.enable = lib.mkEnableOption "unifi";

  config = lib.mkIf config.brooklyn.programs.unifi.enable {
    services.unifi = {
      enable = true;
      openFirewall = true;
      mongodbPackage = nixpkgs-mongodb-7_0_21.mongodb-7_0;
    };
  };
}