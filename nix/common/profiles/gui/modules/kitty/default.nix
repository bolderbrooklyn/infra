{ config, lib, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    ../font
    ../../../../modules/bat
    ../../../../modules/catppuccin
  ];

  options.brooklyn.programs.kitty.enable = lib.mkEnableOption "kitty";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
