{ config, lib, ... }:
{
  options.brooklyn.programs.television.enable = lib.mkEnableOption "television";

  config.programs.television = {
    inherit (config.brooklyn.programs.television) enable;

    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };
}
