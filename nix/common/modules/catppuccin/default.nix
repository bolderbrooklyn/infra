{ catppuccin, config, ... }:
{
  home-manager.users.${config.common.username} = {
    imports = [ catppuccin.homeModules.catppuccin ];

    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";

      nvim.enable = false;
    };
  };
}
