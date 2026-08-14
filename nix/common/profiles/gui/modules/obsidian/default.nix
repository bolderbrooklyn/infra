{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  imports = [
    ../font
  ];

  options.brooklyn.programs.obsidian.enable = lib.mkEnableOption "obsidian";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
