{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.kubectl.enable = lib.mkEnableOption "kubectl";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
