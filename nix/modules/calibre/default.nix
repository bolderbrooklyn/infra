{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.calibre.enable = true;
  };
}
