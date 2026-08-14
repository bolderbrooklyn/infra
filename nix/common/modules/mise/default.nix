{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.mise.enable = lib.mkEnableOption "mise";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
