{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.yazi.enable = lib.mkEnableOption "yazi" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.yazi.enable {
    programs.yazi.enable = true;
  };
}
