{ config, lib, ... }:
{
  imports = [ ../font ];

  options.brooklyn.programs.alacritty.enable = lib.mkEnableOption "alcritty";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
