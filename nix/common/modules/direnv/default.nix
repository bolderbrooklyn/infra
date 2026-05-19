{ config, ... }:
{
  home-manager.users.${config.common.username} = {
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
