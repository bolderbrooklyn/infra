{ catppuccin, config, ... }:
{
  home-manager.users.${config.common.username} = {
    imports = [ catppuccin.homeModules.catppuccin ];

    catppuccin = {
      enable = true;
      flavor = "mocha";

      nvim = {
        enable = true;
        settings = {
          float = {
            transparent = true;
          };

          transparent_background = true;
        };
      };
    };
  };
}
