{ config, lib, ... }:
{
  options.brooklyn.programs.eza.enable = lib.mkEnableOption "eza";

  config = {
    programs.eza = {
      inherit (config.brooklyn.programs.eza) enable;
      git = config.programs.git.enable;

      extraOptions = [
        "--group-directories-first"
        "--group"
      ];
    };
  };
}
