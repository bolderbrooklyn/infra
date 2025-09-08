{ config, lib, ... }:
{
  options.starship.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf config.starship.enable {
    home-manager.users.${config.common.username}.programs.starship = {
      enable = true;

      settings = {
        direnv.disabled = !config.direnv.enable;
        gcloud.disabled = true;
        nix_shell.symbol = " ";
        scala.detect_folders = [ ];
        shell.disabled = false;
      };
    };
  };
}
