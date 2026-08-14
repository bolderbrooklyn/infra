{
  catppuccin,
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.catppuccin.enable = lib.mkEnableOption "catppuccin" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
