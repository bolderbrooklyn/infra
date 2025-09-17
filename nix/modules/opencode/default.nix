{
  config,
  lib,
  pkgs,
  ...
}:
let
  useBrew = pkgs.stdenv.isDarwin;
in
{
  home-manager.users.${config.common.username} = {
    programs.opencode = {
      enable = true;
      package = lib.mkIf useBrew null;

      settings = {
        theme = "catppuccin";
      };
    };
  };
}
