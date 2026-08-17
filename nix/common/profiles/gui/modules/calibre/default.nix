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
      home-manager.users.${username} = {
        programs.calibre = {
          inherit (config.brooklyn.programs.calibre) enable;

          package = lib.mkIf isDarwin null;
        };
      };
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "calibre" ];
    }
  );
}
