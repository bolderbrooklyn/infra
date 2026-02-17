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
      default = "CaskaydiaCove NF";
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
