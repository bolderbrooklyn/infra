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
    home-manager.users.${config.common.username} = {
      programs.yazi.enable = true;
    };
  };
}
