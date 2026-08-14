{ config, lib, ... }:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  imports = [
    ../font
    ../../../../modules/nvim
  ];

  options.brooklyn.programs.neovide.enable = lib.mkEnableOption "neovide";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
