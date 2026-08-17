{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.eza.enable = lib.mkEnableOption "eza" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.eza.enable (
    let
      cfg = config.brooklyn.programs.eza;
    in
    {
      home-manager.users.${config.common.username} =
        { config, ... }:
        {
          programs.eza = {
            enable = cfg.enable;
            git = config.programs.git.enable;

            extraOptions = [
              "--group-directories-first"
              "--group"
            ];
          };
        };
    }
  );
}
