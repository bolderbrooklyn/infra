{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.xonsh.enable = lib.mkEnableOption "xonsh";

  config = lib.mkIf config.brooklyn.programs.xonsh.enable {
    environment.systemPackages = [ pkgs.xonsh ];
    environment.shells = [ pkgs.xonsh ];
  };
}
