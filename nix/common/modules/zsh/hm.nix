{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.zsh.enable = lib.mkEnableOption "zsh" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.zsh.enable {
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
