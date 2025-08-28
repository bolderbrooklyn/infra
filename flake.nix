{
  description = "Infrastructure flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    _1password-shell-plugins.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      nix-darwin,
      home-manager,
      agenix,
      ...
    }:
    {
      nixosConfigurations.tinkaton = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./nix/hosts/tinkaton
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          ./home
        ];
      };

      darwinConfigurations."Miraidon" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };

        modules = [
          ./nix/hosts/miraidon
          home-manager.darwinModules.home-manager
          ./home
          ./home/darwin.nix
        ];
      };

      darwinConfigurations."Okidogi" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };

        modules = [
          ./nix/hosts/okidogi
          home-manager.darwinModules.home-manager
          ./home
          ./home/darwin.nix
        ];
      };
    };
}
