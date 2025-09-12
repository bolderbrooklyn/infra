{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    home.shellAliases = {
      cat = "bat";
    };

    programs.bat.enable = true;
  };
}
