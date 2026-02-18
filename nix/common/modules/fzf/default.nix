{ config, pkgs, ... }:
let
  inherit (config.common) username;
in
{
  imports = [ ../fd ];

  home-manager.users.${username} = {
    programs.fzf = {
      enable = true;

      defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden";
      changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d --hidden";
    };
  };
}
