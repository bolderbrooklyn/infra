{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.xonsh.enable = lib.mkEnableOption "xonsh";

  config = lib.mkIf config.brooklyn.programs.xonsh.enable {
    home.packages = [ pkgs.xonsh ];
  };
}
