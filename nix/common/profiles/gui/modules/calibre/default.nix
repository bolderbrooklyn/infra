{
  config,
  lib,
  isDarwin,
  ...
}:
let
  inherit (config.common) username;
in
{
  options.brooklyn.programs.calibre.enable = lib.mkEnableOption "calibre";

  config = lib.mkIf config.brooklyn.programs.calibre.enable (
    {
      home-manager.sharedModules = [ ./hm.nix ];
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "calibre" ];
    }
  );
}
