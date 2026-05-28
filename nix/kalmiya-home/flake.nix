{
  description = "Kalmiya home-manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        darwin.follows = "";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "";
      };
    };
  };

  outputs =
    { nixpkgs, home-manager, agenix, ... }:
    {
      homeConfigurations.kalmiya = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          inherit agenix;
        };
      };
    };
}
