{ catppuccin, config, ... }:
{
  home-manager.users.${config.common.username} = {
    imports = [ catppuccin.homeModules.catppuccin ];

    catppuccin = {
      enable = true;
      flavor = "mocha";
      autoEnable = true;

      nvim.enable = false;
    };
  };
}
