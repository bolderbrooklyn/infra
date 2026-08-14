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
    programs.btop = {
      enable = true;

      settings = {
        vim_keys = true;
      };
    };
  };
}
