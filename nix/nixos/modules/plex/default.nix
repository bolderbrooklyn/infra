{
  config,
  lib,
  ...
}:
{
  imports = [ ../media ];

  options.brooklyn.programs.plex.enable = lib.mkEnableOption "plex" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.plex.enable {
    systemd.services.plex.requires = [ "mnt-genesect-media.mount" ];

    services = {
      plex = {
        enable = true;
        openFirewall = true;
      };

      tautulli = {
        enable = true;
        openFirewall = true;
      };
    };

    users.groups.media.members = [ "plex" ];
  };
}