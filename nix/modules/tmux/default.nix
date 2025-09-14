{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.tmux = {
      enable = true;

      clock24 = true;
      keyMode = "vi";
      mouse = true;
      shortcut = "a";
      terminal = "xterm-256color";

      extraConfig = ''
        set -g status-position top
      '';
    };
  };
}
