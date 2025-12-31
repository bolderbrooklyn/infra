{ pkgs, ... }:
let
  transmissionAfter = [
    "mnt-genesect-media.mount"
  ];

  servarrAfter = transmissionAfter ++ [
    "transmission.service"
  ];
in
{
  systemd.services.transmission.after = transmissionAfter;
  systemd.services.prowlarr.after = servarrAfter;
  systemd.services.radarr.after = servarrAfter;
  systemd.services.sonarr.after = servarrAfter;
  systemd.services.lidarr.after = servarrAfter;
  systemd.services.readarr.after = servarrAfter;

  systemd.services.transmission.requires = transmissionAfter;
  systemd.services.prowlarr.requires = servarrAfter;
  systemd.services.radarr.requires = servarrAfter;
  systemd.services.sonarr.requires = servarrAfter;
  systemd.services.lidarr.requires = servarrAfter;
  systemd.services.readarr.requires = servarrAfter;

  systemd.services.transmission.serviceConfig.BindPaths = [ "/mnt/genesect/passport/Downloads" ];

  services = {
    transmission = {
      enable = true;
      package = pkgs.transmission_4;
      group = "media";
      openRPCPort = true;
      openPeerPorts = true;

      settings = {
        blocklist-enabled = true;
        blocklist-url = "https://raw.githubusercontent.com/Naunter/BT_BlockLists/master/bt_blocklists.gz";
        download-dir = "/mnt/genesect/media/Downloads";
        incomplete-dir = "/mnt/genesect/media/Downloads/.incomplete";
        rpc-bind-address = "0.0.0.0";
        rpc-host-whitelist-enabled = false;
        rpc-whitelist-enabled = false;
        umask = 0;
      };
    };

    flaresolverr = {
      enable = true;
    };

    prowlarr = {
      enable = true;
      openFirewall = true;

      settings.auth.method = "External";
    };

    radarr = {
      enable = true;
      group = "media";
      openFirewall = true;

      settings.auth.method = "External";
    };

    sonarr = {
      enable = true;
      group = "media";
      openFirewall = true;

      settings.auth.method = "External";
    };

    lidarr = {
      enable = true;
      group = "media";
      openFirewall = true;

      settings.auth.method = "External";
    };

    readarr = {
      enable = true;
      group = "media";
      openFirewall = true;

      settings.auth.method = "External";
    };
  };
}
