{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.fzf.enable = lib.mkEnableOption "fzf" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.fzf.enable {
    programs.fzf = {
      enable = true;

      defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden";
      changeDirWidget.command = "${pkgs.fd}/bin/fd --type d --hidden";
    };
  };
}
