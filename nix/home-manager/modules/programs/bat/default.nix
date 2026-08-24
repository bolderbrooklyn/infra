{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.bat.enable = lib.mkEnableOption "bat";

  config = lib.mkIf config.brooklyn.programs.bat.enable {
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
