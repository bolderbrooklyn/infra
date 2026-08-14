{
  config,
  lib,
  pkgs,
  ...
}:
let
  pwsh = pkgs.powershell;
in
{
  options.brooklyn.programs.powershell = {
    enable = lib.mkEnableOption "powershell";

    extraConfig = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf config.brooklyn.programs.powershell.enable {
    environment.systemPackages = [ pwsh ];
    environment.shells = [ pwsh ];

    home-manager.sharedModules = [ ./hm.nix ];
  };
}
