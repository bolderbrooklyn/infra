{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.eza.enable = lib.mkEnableOption "eza" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
