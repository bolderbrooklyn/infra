{
  config,
  lib,
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  home-manager.users.${config.common.username} =
    { config, ... }:
    {
      home.sessionPath = lib.mkIf isDarwin [ "${config.home.homeDirectory}/.opencode/bin" ];

      programs.opencode = {
        enable = true;
        package = lib.mkIf isDarwin null;

        settings = {
          theme = "catppuccin";
          autoupdate = lib.mkIf (!isDarwin) false;
        };
      };
    };
}
