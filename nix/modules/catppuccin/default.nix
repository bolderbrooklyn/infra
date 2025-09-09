{ config, inputs, ... }:
{
  home-manager.users.${config.common.username} = {
    imports = [ inputs.catppuccin.homeModules.catppuccin ];

    catppuccin = {
      enable = true;
      flavor = "mocha";
    };
  };
}
