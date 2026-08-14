{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.copilot-cli.enable = lib.mkEnableOption "copilot-cli";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
