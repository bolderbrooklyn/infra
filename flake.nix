{
  description = "Infrastructure flake";

  inputs = {
    nixpkgs-25-05.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-mongodb-7_0_21.url = "github:NixOS/nixpkgs/50d5614029a8afcbdff6dc1663dd428eafb752f4";

    systems.url = "github:nix-systems/default";

    llm-agents.url = "github:numtide/llm-agents.nix";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager-25-05 = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-25-05";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    _1password-shell-plugins = {
      # url = "github:1Password/shell-plugins";
      url = "github:jbhannah/shell-plugins/trunk";

      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        systems.follows = "systems";
      };
    };

    agenix = {
      url = "github:ryantm/agenix";

      inputs = {
        darwin.follows = "";
        home-manager.follows = "home-manager-unstable";
        nixpkgs.follows = "nixpkgs-unstable";
        systems.follows = "systems";
      };
    };

    catppuccin-25-05 = {
      url = "github:catppuccin/nix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-25-05";
    };

    catppuccin-unstable = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
    homebrew-oven-sh-bun = {
      url = "github:oven-sh/homebrew-bun";
      flake = false;
    };
    homebrew-pkpw = {
      url = "github:jbhannah/pkpw";
      flake = false;
    };

    nix-moltbot = {
      url = "github:das-monki/nix-clawdbot/nixos-aarch64-support";

      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager-unstable";
      };
    };

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    inputs@{
      nixpkgs-unstable,
      nix-darwin,
      home-manager-unstable,
      agenix,
      catppuccin-unstable,
      mac-app-util,
      ...
    }:
    {
      nixosConfigurations.tinkaton = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          home-manager = home-manager-unstable;
          catppuccin = catppuccin-unstable;
        };

        modules = [
          ./nix/nixos/hosts/tinkaton
          agenix.nixosModules.default
        ];
      };

      darwinConfigurations."Miraidon" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs mac-app-util;
          home-manager = home-manager-unstable;
          catppuccin = catppuccin-unstable;
        };

        modules = [
          ./nix/darwin/hosts/miraidon
        ];
      };
    };
}
