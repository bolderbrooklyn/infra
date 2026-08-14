{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.docker.enable = lib.mkEnableOption "docker" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
