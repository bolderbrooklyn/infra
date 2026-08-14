{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.buku.enable = lib.mkEnableOption "buku";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
