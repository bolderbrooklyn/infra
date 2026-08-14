{ config, lib, ... }:
{
  options.brooklyn.programs.qutebrowser.enable = lib.mkEnableOption "qutebrowser" // {
    default = false;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
