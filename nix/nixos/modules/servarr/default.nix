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
  systemd.services = {
    transmission = {
      after = transmissionAfter;
      requires = transmissionAfter;
      serviceConfig.BindPaths = [ "/mnt/genesect/passport/Downloads" ];
    };
    prowlarr = {
      after = servarrAfter;
      requires = servarrAfter;
    };
    radarr = {
      after = servarrAfter;
      requires = servarrAfter;
    };
    sonarr = {
      after = servarrAfter;
      requires = servarrAfter;
    };
    lidarr = {
      after = servarrAfter;
      requires = servarrAfter;
    };
  };

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

    ombi = {
      enable = true;
      group = "media";
      openFirewall = true;
    };
  };
}
