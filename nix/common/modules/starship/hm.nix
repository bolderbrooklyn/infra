{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.starship.enable = lib.mkEnableOption "starship" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.starship.enable {
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
}
