{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.gnupg.enable = lib.mkEnableOption "gnupg";

  config = {
    programs.gpg = {
      inherit (config.brooklyn.programs.gnupg) enable;
    };

    services.gpg-agent = {
      inherit (config.brooklyn.programs.gnupg) enable;

      pinentry.package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin pkgs.pinentry_mac;
    };
  };
}
