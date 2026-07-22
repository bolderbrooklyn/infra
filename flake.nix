{
  description = "Infrastructure flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-25_11.url = "github:NixOS/nixpkgs/release-25.11";

    nixpkgs-mongodb-7_0_21.url = "github:NixOS/nixpkgs/50d5614029a8afcbdff6dc1663dd428eafb752f4";

    systems.url = "github:nix-systems/default";

    llm-agents = {
      url = "github:numtide/llm-agents.nix";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    _1password-shell-plugins = {
      url = "github:1Password/shell-plugins";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    agenix = {
      url = "github:ryantm/agenix";

      inputs = {
        darwin.follows = "nix-darwin";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    catppuccin.url = "github:catppuccin/nix";

    catppuccin-warp = {
      url = "github:catppuccin/warp";
      flake = false;
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:Homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-pkpw = {
      url = "github:jbhannah/pkpw";
      flake = false;
    };
    homebrew-withgraphite = {
      url = "github:withgraphite/homebrew-tap";
      flake = false;
    };
    homebrew-sikarugir = {
      url = "github:Sikarugir-App/homebrew-sikarugir";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nix-darwin,
      ...
    }:
    let
      baseSpecialArgs = {
        inherit inputs;
        inherit (inputs) agenix catppuccin home-manager;
        isDarwin = false;
      };
    in
    {
      nixosConfigurations.tinkaton =
        let
          specialArgs = baseSpecialArgs;
        in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;

          system = "x86_64-linux";

          modules = [
            ./nix/nixos/hosts/tinkaton
          ];
        };

      darwinConfigurations =
        let
          system = "aarch64-darwin";

          specialArgs = baseSpecialArgs // {
            isDarwin = true;
          };
        in
        {
          miraidon = nix-darwin.lib.darwinSystem {
            inherit system specialArgs;

            modules = [
              ./nix/darwin/hosts/miraidon
            ];
          };

          xerneas = nix-darwin.lib.darwinSystem {
            inherit system specialArgs;

            modules = [
              ./nix/darwin/hosts/xerneas
            ];
          };

          comfey = nix-darwin.lib.darwinSystem {
            inherit system specialArgs;

            modules = [
              ./nix/darwin/hosts/comfey
            ];
          };
        };
    };
}
