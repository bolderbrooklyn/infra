{
  config,
  lib,
  ...
}:
{
  imports = [ ../media ];

  options.brooklyn.programs.jellyfin.enable = lib.mkEnableOption "jellyfin" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.jellyfin.enable {
    systemd.services.jellyfin.requires = [ "mnt-genesect-media.mount" ];

    services = {
      jellyfin = {
        enable = true;
        openFirewall = true;

        hardwareAcceleration = {
          enable = true;
          device = "/dev/dri/renderD128";
          type = "qsv";
        };

        transcoding = {
          enableHardwareEncoding = true;
          enableIntelLowPowerEncoding = true;
        };
      };
    };

    users.groups.media.members = [ "jellyfin" ];
  };
}