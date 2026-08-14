{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.crush.enable = lib.mkEnableOption "crush";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
