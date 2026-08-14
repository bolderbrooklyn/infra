{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.fd.enable = lib.mkEnableOption "fd" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
