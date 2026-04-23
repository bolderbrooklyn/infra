{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.qutebrowser = { };
  };
}
