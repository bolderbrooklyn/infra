{ config, ... }:
let
  tunarr = {
    name = "tunarr";
    uid = 30200;
    baseDir = "/var/lib/tunarr";

    webPort = 8000;
  };
in
{
  imports = [ ../podman ];

  users.groups.tunarr = {
    gid = tunarr.uid;
  };

  users.users.tunarr = {
    isSystemUser = true;
    uid = tunarr.uid;
    group = tunarr.name;
  };

  systemd.tmpfiles.rules = [
    "d ${tunarr.baseDir} 0755 1000 0 - -"
  ];

  virtualisation.oci-containers.containers.tunarr = {
    image = "ghcr.io/tunarr/tunarr:latest";
    autoStart = true;
    pull = "newer";

    ports = [
      "${tunarr.webPort}:8000"
    ];

    devices = [
      "/dev/dri"
    ];

    volumes = [
      "${tunarr.baseDir}:/config/tunarr"
    ];

    environment = {
      TUNARR_SERVER_TRUST_PROXY = "TRUE";
      TZ = config.time.timeZone;
    };
  };
}
