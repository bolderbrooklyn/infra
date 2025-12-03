{ config, ... }:
let
  romm = {
    libraryDir = "/mnt/genesect/emulation";
    stateDir = "/var/lib/romm";
    port = 12000;
  };
in
{
  imports = [ ../podman ];

  virtualisation.oci-containers.containers.romm = {
    image = "rommapp/romm:latest";
    autoStart = true;
    pull = "newer";

    dependsOn = [ "romm-db" ];

    ports = [ "${builtins.toString romm.port}:8080/tcp" ];

    volumes = [
      "${romm.libraryDir}/library:/romm/library"
      "${romm.stateDir}/resources:/romm/resources"
      "${romm.libraryDir}/assets:/romm/assets"
      "${romm.stateDir}/config:/romm/config"
      "${romm.stateDir}/redis-data:/redis-data"
    ];

    environment = {
      DB_HOST = "romm-db";
      DB_NAME = "romm";
      DB_USER = "romm-user";
      DB_PASSWD = "romm";
      HLTB_API_ENABLED = "true";
      PLAYMATCH_API_ENABLED = "true";
      TZ = config.time.timeZone;
    };

    environmentFiles = [
      config.age.secrets.romm.path
    ];
  };

  virtualisation.oci-containers.containers.romm-db = {
    image = "mariadb:latest";
    autoStart = true;
    pull = "newer";

    volumes = [
      "${romm.stateDir}/db:/var/lib/mysql"
    ];

    environment = {
      MARIADB_ROOT_PASSWORD = "romm";
      MARIADB_DATABASE = "romm";
      MARIADB_USER = "romm-user";
      MARIADB_PASSWORD = "romm";
      TZ = config.time.timeZone;
    };
  };

  fileSystems."${romm.libraryDir}" = {
    device = "genesect.home.local:/nfs/Emulation";
    fsType = "nfs";
    options = [
      "noatime"
      "nodiratime"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    romm.port
  ];
}
