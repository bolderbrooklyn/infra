{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.crush.enable = lib.mkEnableOption "crush";

  config = lib.mkIf config.brooklyn.programs.crush.enable {
    home.packages = with pkgs.llm-agents; [
      crush
    ];

    xdg.configFile."crush/crush.json" = {
      source = pkgs.writeText "crush.json" (
        builtins.toJSON {
          "$schema" = "https://charm.land/crush.json";
        }
      );
    };
  };
}
