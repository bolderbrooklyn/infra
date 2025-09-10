{ config, pkgs, ... }:
{
  home-manager.users.${config.common.username} = {
    home.packages = [ pkgs.devenv ];

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
