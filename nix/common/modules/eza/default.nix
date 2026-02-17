{ config, ... }:
{
  config = {
    home-manager.users.${config.common.username} =
      { config, ... }:
      {
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
