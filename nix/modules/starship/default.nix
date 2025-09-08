{ config, lib, ... }:
{
  options.programs.starship = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.programs.starship.enable {
    programs.powershell.extraConfig = lib.mkIf config.programs.powershell.enable [
      "Invoke-Expression (&starship init powershell)"
    ];

    home-manager.users.${config.common.username}.programs.starship = {
      enable = true;

      settings = {
        direnv.disabled = !config.programs.direnv.enable;
        gcloud.disabled = true;
        nix_shell.symbol = " ";
        scala.detect_folders = [ ];
        shell.disabled = false;
      };
    };
  };
}
