{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.font = {
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
      default = 10;
    };
  };

  config = {
    fonts.fontconfig = {
      enable = true;
      defaultFonts.monospace = [ config.brooklyn.font.name ];
    };

    home.packages = [ config.brooklyn.font.package ];
  };
}
