{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../catppuccin ];

  options.brooklyn.programs.claude-code.enable = lib.mkEnableOption "claude-code";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
