{ config, ... }:
{
  config = {
    home-manager.users.${config.common.username} =
      { config, ... }:
      {
        home.shellAliases = {
          l = "eza -alh";
        };

        programs.eza = {
          enable = true;
          git = config.programs.git.enable;

          extraOptions = [
            "--group-directories-first"
            "--group"
          ];
        };
      };
  };
}
