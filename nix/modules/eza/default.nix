{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.programs.eza = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.programs.eza.enable {
    home-manager.users.${config.common.username} = {
      home.shellAliases = {
        l = "${pkgs.eza}/bin/eza -alh";
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
