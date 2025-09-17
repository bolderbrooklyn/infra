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
    programs.gemini-cli = {
      enable = true;
      package = lib.mkIf useBrew null;

      settings = {
        preferredEditor = "nvim";
        selectedAuthType = "oauth-personal";
        vimMode = true;
      };
    };
  };
}
