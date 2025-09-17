{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.aerospace = {
      enable = true;
      launchd.enable = true;
    };
  };
}
