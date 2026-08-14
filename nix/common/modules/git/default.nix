{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.git.enable = lib.mkEnableOption "git" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
