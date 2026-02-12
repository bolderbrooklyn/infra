{ catppuccin, config, ... }:
{
  home-manager.users.${config.common.username} = {
    imports = [ catppuccin.homeModules.catppuccin ];

    catppuccin = {
      enable = true;
      flavor = "mocha";

      nvim.settings = {
        transparent_background = true;

        float = {
          transparent = true;
        };
      };
    };
  };
}
