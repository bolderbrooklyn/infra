{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.nushell.enable = lib.mkEnableOption "nushell";

  config = lib.mkIf config.brooklyn.programs.nushell.enable {
    environment.systemPackages = [ pkgs.nushell ];
    environment.shells = [ pkgs.nushell ];

    home-manager.sharedModules = [ ./hm.nix ];
  };
}
