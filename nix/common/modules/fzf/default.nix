{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../fd ];

  options.brooklyn.programs.fzf.enable = lib.mkEnableOption "fzf" // {
    default = true;
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
