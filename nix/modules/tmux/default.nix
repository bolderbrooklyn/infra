{ config, pkgs, ... }:
{
  home-manager.users.${config.common.username} = {
    programs.tmux = {
      enable = true;

      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 10000;
      keyMode = "vi";
      mouse = true;
      shortcut = "a";
      terminal = "tmux-256color";

      plugins = with pkgs.tmuxPlugins; [
        tmux-powerline
      ];

      extraConfig = ''
        set -g status-position top
      '';

    };

    xdg.configFile.tmux-powerline = {
      source = ./config/tmux-powerline;
      recursive = true;
    };
  };
}
