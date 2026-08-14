{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.gnupg.enable = lib.mkEnableOption "gnupg" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
