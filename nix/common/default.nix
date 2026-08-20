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
    ./modules/antigravity-cli
    ./modules/buku
    ./modules/claude-code
    ./modules/codex
    ./modules/copilot-cli
    ./modules/crush
    ./modules/docker
    ./modules/fish
    ./modules/gcloud-cli
    ./modules/gnupg
    ./modules/kubectl
    ./modules/mise
    ./modules/nushell
    ./modules/opencode
    ./modules/openssh
    ./modules/powershell
    ./modules/xonsh
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
        inputs.llm-agents.overlays.shared-nixpkgs
        inputs.nix-obsidian-extensions.overlays.default
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
      fish.defaultShell = true;
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
