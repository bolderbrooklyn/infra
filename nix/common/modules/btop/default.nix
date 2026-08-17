{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.btop.enable = lib.mkEnableOption "btop" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.btop.enable {
    home-manager.users.${config.common.username} = {
      programs.btop = {
        enable = true;

        settings = {
          vim_keys = true;
        };
      };
    };
  };
}
