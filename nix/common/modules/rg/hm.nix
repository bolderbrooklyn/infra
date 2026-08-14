{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.ripgrep.enable = lib.mkEnableOption "ripgrep" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.ripgrep.enable {
    home.shellAliases = {
      grep = "rg";
    };

    programs.ripgrep = {
      enable = true;
    };
  };
}
