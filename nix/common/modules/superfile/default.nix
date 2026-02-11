{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.superfile.enable = true;
  };
}
