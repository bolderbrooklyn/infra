{ config, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.tmux = {
      enable = true;

      clock24 = true;
      escapeTime = 0;
      keyMode = "vi";
      mouse = true;
      newSession = true;
      sensibleOnTop = true;
      shortcut = "a";
      terminal = "xterm-256color";

      extraConfig = ''
        set -g status-position top
      '';
    };
  };
}
