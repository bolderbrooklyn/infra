{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.ripgrep.enable = lib.mkEnableOption "ripgrep" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
