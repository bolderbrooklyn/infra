{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.yazi.enable = lib.mkEnableOption "yazi" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
