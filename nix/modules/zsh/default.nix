{ config, pkgs, ... }:
{
  programs.zsh.enable = true;

  environment.shells = [ pkgs.zsh ];

  home-manager.users.${config.common.username} =
    { config, ... }:
    {
      programs.zsh = {
        enable = true;

        autocd = true;
        defaultKeymap = "viins";
        dotDir = "${config.xdg.configHome}/zsh";

        history = {
          append = true;
          extended = true;
          ignoreAllDups = true;
        };

        syntaxHighlighting = {
          enable = true;
        };
      };
    };
}
