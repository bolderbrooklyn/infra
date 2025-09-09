{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.programs.zsh.enable {
  environment.shells = [ pkgs.zsh ];

  home-manager.users.${config.common.username} = {
    programs.zsh = {
      enable = true;

      autocd = true;
      defaultKeymap = "viins";

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
