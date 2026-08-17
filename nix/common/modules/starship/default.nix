{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.starship.enable = lib.mkEnableOption "starship" // {
    default = true;
  };

  imports = [
    ../powershell
  ];

  config = lib.mkIf config.brooklyn.programs.starship.enable {
    brooklyn.programs.powershell.extraConfig = lib.mkIf config.brooklyn.programs.powershell.enable [
      "Invoke-Expression (&starship init powershell)"
    ];

    home-manager.users.${config.common.username} =
      { config, ... }:
      {
        programs.starship = {
          enable = true;

          settings = {
            direnv.disabled = !config.programs.direnv.enable;
            gcloud.disabled = true;
            nix_shell.symbol = "󱄅 ";
            scala.detect_folders = [ ];
            shell.disabled = false;
          };
        };
      };
  };
}
