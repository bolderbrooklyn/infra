{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.nushell.enable = lib.mkEnableOption "nushell";

  config = lib.mkIf config.brooklyn.programs.nushell.enable {
    home.packages = [ pkgs.nushell ];
  };
}
