{
  catppuccin,
  config,
  lib,
  ...
}:
{
  options.brooklyn.catppuccin.enable = lib.mkEnableOption "catppuccin" // {
    default = true;
  };

  imports = [ catppuccin.homeModules.catppuccin ];

  config = lib.mkIf config.brooklyn.catppuccin.enable {
    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";

      nvim.enable = false;
    };
  };
}
