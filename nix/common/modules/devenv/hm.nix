{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.devenv.enable = lib.mkEnableOption "devenv" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.devenv.enable {
    home.packages = [ pkgs.devenv ];

    programs.fish.interactiveShellInit = ''
      devenv hook fish | source
    '';
  };
}
