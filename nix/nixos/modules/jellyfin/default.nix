{
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
}
