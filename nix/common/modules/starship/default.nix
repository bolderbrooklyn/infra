{
  config,
  lib,
  ...
}:
{
  imports = [
    ../powershell
  ];

  options.brooklyn.programs.starship.enable = lib.mkEnableOption "starship" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.starship.enable {
    brooklyn.programs.powershell.extraConfig = lib.mkIf config.brooklyn.programs.powershell.enable [
      "Invoke-Expression (&starship init powershell)"
    ];

    home-manager.sharedModules = [ ./hm.nix ];
  };
}
