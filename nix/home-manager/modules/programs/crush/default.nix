{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.crush.enable = lib.mkEnableOption "crush";

  config.programs.crush = {
    inherit (config.brooklyn.programs.crush) enable;

    package = pkgs.llm-agents.crush;
  };
}
