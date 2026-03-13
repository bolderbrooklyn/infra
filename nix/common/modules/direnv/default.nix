{
  config,
  inputs,
  pkgs,
  ...
}:
let
  nixpkgs-25_11 = import inputs.nixpkgs-25_11 {
    inherit (pkgs.stdenv.hostPlatform) system;
  };
in
{
  home-manager.users.${config.common.username} = {
    home.packages = [ nixpkgs-25_11.devenv ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;

      config = {
        hide_env_diff = true;
        strict_env = true;
        warn_timeout = "30s";
      };
    };
  };
}
