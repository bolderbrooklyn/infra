{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.gnupg.enable = lib.mkEnableOption "gnupg" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.gnupg.enable {
    home-manager.users.${config.common.username} = {
      programs.gpg.enable = true;

      services.gpg-agent = {
        enable = true;
        pinentry.package = lib.mkIf pkgs.stdenv.isDarwin pkgs.pinentry_mac;
      };
    };
  };
}
