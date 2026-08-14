{
  config,
  lib,
  ...
}:
let
  cfg = config.brooklyn.programs.eza;
in
{
  options.brooklyn.programs.eza.enable = lib.mkEnableOption "eza" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = cfg.enable;
      git = config.programs.git.enable;

      extraOptions = [
        "--group-directories-first"
        "--group"
      ];
    };
  };
}
