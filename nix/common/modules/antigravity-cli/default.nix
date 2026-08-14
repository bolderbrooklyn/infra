{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.antigravity-cli = {
    enable = lib.mkEnableOption "antigravity-cli";
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
