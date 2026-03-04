{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.zathura = {
      enable = true;
    };
  };
}
