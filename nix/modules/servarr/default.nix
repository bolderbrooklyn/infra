{ pkgs, ... }:
{
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
