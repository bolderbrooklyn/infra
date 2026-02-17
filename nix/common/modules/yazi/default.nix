{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
    };
  };
}
