{
  config,
  lib,
  isDarwin,
  ...
}:
{
  options.brooklyn.programs.calibre.enable = lib.mkEnableOption "calibre";

  config = lib.mkIf config.brooklyn.programs.calibre.enable {
    programs.calibre = {
      inherit (config.brooklyn.programs.calibre) enable;

      package = lib.mkIf isDarwin null;
    };
  };
}
