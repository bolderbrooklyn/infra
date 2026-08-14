{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.bat.enable = lib.mkEnableOption "bat" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
