{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.codex.enable = lib.mkEnableOption "codex";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
