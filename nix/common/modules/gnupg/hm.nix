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
    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      pinentry.package = lib.mkIf pkgs.stdenv.isDarwin pkgs.pinentry_mac;
    };
  };
}
