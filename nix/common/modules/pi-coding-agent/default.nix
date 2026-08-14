{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.pi-coding-agent.enable = lib.mkEnableOption "pi-coding-agent";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
