{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.devenv.enable = lib.mkEnableOption "devenv" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
