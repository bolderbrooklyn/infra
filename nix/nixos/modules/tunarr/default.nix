{
  config,
  lib,
  ...
}:
let
  tunarr = {
    name = "tunarr";
    uid = 30200;
    baseDir = "/var/lib/tunarr";

    webPort = 8000;
  };
in
{
  options.brooklyn.programs.tunarr.enable = lib.mkEnableOption "tunarr";

  config = lib.mkIf config.brooklyn.programs.tunarr.enable {
    users.groups.tunarr = {
      gid = tunarr.uid;
    };

    users.users.tunarr = {
      inherit (tunarr) uid;
      isSystemUser = true;
      group = tunarr.name;
    };

    systemd.tmpfiles.rules = [
      "d ${tunarr.baseDir} 0755 0 0 - -"
    ];

    virtualisation.oci-containers.containers.tunarr = {
      image = "chrisbenincasa/tunarr:latest";
      autoStart = true;
      pull = "newer";

      ports = [
        "${toString tunarr.webPort}:8000"
      ];

      devices = [
        "/dev/dri"
      ];

      volumes = [
        "${tunarr.baseDir}:/config/tunarr"
      ];

      environment = {
        TUNARR_DATABASE_PATH = "/config/tunarr";
        TUNARR_SERVER_TRUST_PROXY = "TRUE";
        TZ = config.time.timeZone;
      };
    };

    networking.firewall.allowedTCPPorts = [
      tunarr.webPort
    ];
  };
}