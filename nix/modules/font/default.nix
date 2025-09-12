{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.gui.font = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "Cascadia Code NF";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.cascadia-code;
    };

    size = lib.mkOption {
      type = lib.types.int;
      default = 15;
    };
  };

  config = {
    home-manager.users.${config.common.username} = {
      home.packages = [ config.gui.font.package ];
    };
  };
}
