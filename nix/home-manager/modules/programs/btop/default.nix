{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.btop.enable = lib.mkEnableOption "btop";

  config = {
    programs.btop = {
      inherit (config.brooklyn.programs.btop) enable;

      settings = {
        vim_keys = true;
      };
    };
  };
}
