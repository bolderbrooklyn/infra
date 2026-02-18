{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
in
{
  home-manager.users.${username} = {
    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      pinentry.package = lib.mkIf pkgs.stdenv.isDarwin pkgs.pinentry_mac;
    };
  };
}
