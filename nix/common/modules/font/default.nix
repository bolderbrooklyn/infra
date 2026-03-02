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
      default = "CaskaydiaCove Nerd Font";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.nerd-fonts.caskaydia-cove;
    };

    size = lib.mkOption {
      type = lib.types.int;
      default = 15;
    };
  };

  config = {
    fonts.packages = [ config.gui.font.package ];
  };
}
