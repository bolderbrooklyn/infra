{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.nvim.enable = lib.mkEnableOption "nvim" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
