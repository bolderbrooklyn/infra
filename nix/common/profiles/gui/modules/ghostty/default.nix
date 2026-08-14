{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
  inherit (config.gui) font;
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [ ../font ];

  options.brooklyn.programs.ghostty.enable = lib.mkEnableOption "ghostty";

  config.home-manager.sharedModules = [ ./hm.nix ];
}
