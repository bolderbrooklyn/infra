{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    home.shellAliases = {
      grep = "rg";
    };

    programs.ripgrep = {
      enable = true;
    };
  };
}
