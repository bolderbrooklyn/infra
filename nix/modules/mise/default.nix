{ config, ... }:
{
  config = {
    home-manager.users.${config.common.username} = {
      programs.mise.enable = true;
    };
  };
}
