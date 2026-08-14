{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.btop.enable = lib.mkEnableOption "btop" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
