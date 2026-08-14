{
  catppuccin,
  config,
  lib,
  ...
}:
{
  imports = [
    catppuccin.homeModules.catppuccin
  ];

  options.brooklyn.programs.catppuccin.enable = lib.mkEnableOption "catppuccin" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.catppuccin.enable {
    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";

      nvim.enable = false;
      starship.enable = lib.mkForce false;
    };
  };
}
