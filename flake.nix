{
  description = "Infrastructure flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-mongodb-7_0_21.url = "github:NixOS/nixpkgs/50d5614029a8afcbdff6dc1663dd428eafb752f4";

    systems.url = "github:nix-systems/default";

    llm-agents.url = "github:numtide/llm-agents.nix";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    _1password-shell-plugins = {
      # url = "github:1Password/shell-plugins";
      url = "github:jbhannah/shell-plugins/trunk";

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

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
    homebrew-krunkit = {
      url = "github:slp/krunkit";
      flake = false;
    };
    homebrew-pkpw = {
      url = "github:jbhannah/pkpw";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nix-darwin,
      ...
    }:
    {
      nixpkgs.overlays = [
        (final: prev: {
          inherit (prev.lixPackageSets.stable)
            lix
            nix-direnv
            ;
        })
      ];

      nixosConfigurations.tinkaton = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          inherit (inputs) agenix catppuccin home-manager;
          isDarwin = false;
        };

        modules = [
          ./nix/nixos/hosts/tinkaton
        ];
      };

      darwinConfigurations.miraidon = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;
          inherit (inputs) agenix catppuccin home-manager;
          isDarwin = true;
        };

        modules = [
          ./nix/darwin/hosts/miraidon
        ];
      };

      darwinConfigurations.comfey = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;
          inherit (inputs) agenix catppuccin home-manager;
          isDarwin = true;
        };

        modules = [
          ./nix/darwin/hosts/comfey
        ];
      };
    };
}
