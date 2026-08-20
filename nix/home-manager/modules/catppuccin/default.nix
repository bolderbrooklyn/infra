{
  catppuccin,
  config,
  lib,
  ...
}:
{
  options.brooklyn.catppuccin = {
    enable = lib.mkEnableOption "catppuccin";

    flavor = lib.mkOption {
      type = lib.types.str;
      default = "mocha";
    };
  };

  imports = [ catppuccin.homeModules.catppuccin ];

  config = {
    catppuccin =
      let
        inherit (config.brooklyn.catppuccin) enable flavor;
      in
      {
        inherit enable flavor;
        autoEnable = enable;

        cache.enable = true;
        nvim.enable = false;
      };
  };
}
