{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.programs.bat = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.programs.bat.enable {
    home-manager.users.${config.common.username} = {
      home.shellAliases = {
        cat = "${pkgs.bat}/bin/bat";
      };

      programs.bat.enable = true;
    };
  };
}
