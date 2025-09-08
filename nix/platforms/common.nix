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
    ../modules/1password
    ../modules/nvim
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

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "America/Los_Angeles";

    environment.systemPackages = with pkgs; [
      fish
      git
      vim
      wget
    ];

    environment.shells = with pkgs; [
      fish
    ];

    programs.fish.enable = true;
    programs.zsh.enable = true;

    users.users.${username} = {
      home = home;
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSrqkXtluHRGoNSDuwpPj2pZXlNZFxPFqsmwxjP1X0P"
      ];
    };
  };
}
