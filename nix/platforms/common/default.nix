{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  username = config.common.username;
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
    ../../modules/bat
    ../../modules/catppuccin
    ../../modules/direnv
    ../../modules/eza
    ../../modules/fish
    ../../modules/gemini-cli
    ../../modules/git
    ../../modules/opencode
    ../../modules/nvim
    ../../modules/powershell
    ../../modules/starship
    ../../modules/superfile
    ../../modules/tmux
    ../../modules/zsh
  ];

  config = {
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    nix.package = pkgs.lixPackageSets.stable.lix;

    nix.gc.automatic = true;
    nix.optimise.automatic = true;

    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
    ];

    nix.settings.trusted-users = [
      username
    ];

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "America/Los_Angeles";

    environment.systemPackages = with pkgs; [
      vim
      wget
    ];

    programs.fish = {
      enable = true;
      defaultShell = true;
    };

    programs.zsh.enable = true;

    users.users.${username} = {
      home = home;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSrqkXtluHRGoNSDuwpPj2pZXlNZFxPFqsmwxjP1X0P"
      ];
    };
  };
}
