{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.gui.font = {
    name = mkOption {
      type = types.str;
      default = "CaskaydiaCove Nerd Font";
    };

    package = mkOption {
      type = types.package;
      default = pkgs.nerd-fonts.caskaydia-cove;
    };

    size = mkOption {
      type = types.int;
      default = 15;
    };
  };

  config = {
    home.packages = [ config.gui.font.package ];
  };
}
