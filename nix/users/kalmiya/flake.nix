{
  description = "Kalmiya home-manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      llm-agents,
      ...
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux.appendOverlays [
        llm-agents.overlays.shared-nixpkgs
      ];
    in
    {
      homeConfigurations.kalmiya = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];
      };
    };
}
