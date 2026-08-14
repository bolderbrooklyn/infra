{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.tmux.enable = lib.mkEnableOption "tmux" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
