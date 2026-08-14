{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.tmux.enable = lib.mkEnableOption "tmux" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.tmux.enable {
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
        set -g allow-passthrough on
        set -g status-position top
      '';

    };

    xdg.configFile.tmux-powerline = {
      source = ./config/tmux-powerline;
      recursive = true;
    };
  };
}
