{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    home.shellAliases = {
      cat = "bat";
    };

    programs.bat = {
      enable = true;

      config = {
        # fix mouse scrolling inside tmux
        pager = "less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
      };
    };
  };
}
