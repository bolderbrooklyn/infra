{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
  home = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${username}";
in
{
  options.common = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "brooklyn";
    };
  };

  imports = [
    ./home.nix
    ./modules/1password
    ./modules/agent-instructions
    ./modules/bat
    ./modules/btop
    ./modules/catppuccin
    ./modules/crush
    ./modules/devenv
    ./modules/eza
    ./modules/fd
    ./modules/fish
    ./modules/rg
    ./modules/fzf
    ./modules/git
    ./modules/gnupg
    ./modules/nushell
    ./modules/nvim
    ./modules/openssh
    ./modules/starship
    ./modules/tmux
    ./modules/yazi
    ./modules/zsh
  ];

  config = {
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    nix = {
      package = pkgs.lixPackageSets.latest.lix;

      gc.automatic = true;
      optimise.automatic = true;

      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "flakes"
          "nix-command"
        ];

        trusted-users = [
          username
        ];
      };
    };

    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          inherit (prev.lixPackageSets.latest)
            lix
            ;
        })
        inputs.llm-agents.overlays.default
      ];
    };

    time.timeZone = "America/Los_Angeles";

    environment.systemPackages = with pkgs; [
      ruby_4_0
      python314
      vim
      wget
    ];

    programs = {
      fish = {
        enable = true;
        defaultShell = true;
      };

      zsh.enable = true;
    };

    users.users.${username} = {
      inherit home;
      description = "Brooklyn Hannah";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSrqkXtluHRGoNSDuwpPj2pZXlNZFxPFqsmwxjP1X0P"
      ];
    };
  };
}
