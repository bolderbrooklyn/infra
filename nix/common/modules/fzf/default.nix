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

  imports = [ ../fd ];

  config = lib.mkIf config.brooklyn.programs.fzf.enable {
    home-manager.users.${config.common.username} = {
      programs.fzf = {
        enable = true;

        defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden";
        changeDirWidget.command = "${pkgs.fd}/bin/fd --type d --hidden";
      };
    };
  };
}
