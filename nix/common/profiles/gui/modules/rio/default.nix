{ config, lib, ... }:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  imports = [ ../font ];

  options.brooklyn.programs.rio.enable = lib.mkEnableOption "rio";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
