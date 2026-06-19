{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.crush.enable = lib.mkEnableOption "crush";

  config = lib.mkIf config.brooklyn.programs.crush.enable {
    home-manager.users.${config.common.username} = {
      home.packages = with pkgs.llm-agents; [
        crush
      ];

      xdg.configFile.crush = {
        source = ./config/crush;
        recursive = true;
      };
    };
  };
}
