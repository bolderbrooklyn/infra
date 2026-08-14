{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.agent-instructions.enable = lib.mkEnableOption "agent-instructions" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
