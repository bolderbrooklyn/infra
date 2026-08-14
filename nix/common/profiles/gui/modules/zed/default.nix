{
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  imports = [ ../font ];

  options.brooklyn.programs.zed-editor.enable = lib.mkEnableOption "zed-editor";

  config = lib.mkIf config.brooklyn.programs.zed-editor.enable (
    {
      home-manager.sharedModules = [ ./hm.nix ];
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "zed" ];
    }
  );
}
