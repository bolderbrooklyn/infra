{
  catppuccin,
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.catppuccin.enable = lib.mkEnableOption "catppuccin" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.catppuccin.enable {
    home-manager.users.${config.common.username} = {
      imports = [ catppuccin.homeModules.catppuccin ];

      catppuccin = {
        enable = true;
        autoEnable = true;
        flavor = "mocha";

        nvim.enable = false;
      };
    };
  };
}
