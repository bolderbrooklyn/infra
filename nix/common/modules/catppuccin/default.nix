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

          auto_integrations = true;
          transparent_background = true;

          lsp_styles = {
            underlines = {
              errors = [ "undercurl" ];
              hints = [ "undercurl" ];
              warnings = [ "undercurl" ];
              information = [ "undercurl" ];
            };
          };
        };
      };
    };
  };
}
