{
  config,
  lib,
  ...
}:
let
  romm = {
    name = "romm";
    dbName = "${romm.name}-db";
    uid = 30200;
    storageDir = "/mnt/genesect/emulation";
    libraryDir = "${romm.storageDir}/library";
    assetsDir = "${romm.storageDir}/assets";
    stateDir = "/var/lib/romm";
    resourcesDir = "${romm.storageDir}/resources";
    configDir = "${romm.stateDir}/config";
    redisDataDir = "${romm.stateDir}/redis-data";
    dbDir = "${romm.stateDir}/db";
    port = 8180;
  };
in
{
  options.brooklyn.programs.romm.enable = lib.mkEnableOption "romm" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.romm.enable {
    systemd = {
      tmpfiles.rules = [
        "d ${romm.stateDir} 0755 0 0 - -"
        "d ${romm.configDir} 0755 0 0 - -"
        "d ${romm.dbDir} 0755 0 0 - -"
        "d ${romm.resourcesDir} 0755 0 0 - -"
        "d ${romm.redisDataDir} 0755 0 0 - -"
        "f ${romm.configDir}/config.yml 0644 0 0 - -"
      ];

      services.podman-romm = {
        after = [ "mnt-genesect-emulation.mount" ];
        requires = [ "mnt-genesect-emulation.mount" ];
      };
    };

    virtualisation.oci-containers.containers."${romm.name}" = {
      image = "rommapp/romm:latest";
      autoStart = true;
      pull = "newer";

      dependsOn = [ romm.dbName ];

      ports = [ "${toString romm.port}:8080/tcp" ];

      volumes = [
        "${romm.libraryDir}:/romm/library"
        "${romm.resourcesDir}:/romm/resources"
        "${romm.assetsDir}:/romm/assets"
        "${romm.configDir}:/romm/config"
        "${romm.redisDataDir}:/redis-data"
      ];

      environment = {
        DB_HOST = romm.dbName;
        DB_NAME = romm.dbName;
        DB_USER = romm.dbName;
        PLAYMATCH_API_ENABLED = "true";
        TZ = config.time.timeZone;
      };

      environmentFiles = [
        config.age.secrets.romm.path
      ];
    };

    virtualisation.oci-containers.containers."${romm.dbName}" = {
      image = "mariadb:latest";
      autoStart = true;
      pull = "newer";

      volumes = [
        "${romm.dbDir}:/var/lib/mysql"
      ];

      environment = {
        MARIADB_DATABASE = romm.dbName;
        MARIADB_USER = romm.dbName;
        TZ = config.time.timeZone;
      };

      environmentFiles = [
        config.age.secrets.romm.path
      ];
    };

    fileSystems."${romm.storageDir}" = {
      device = "genesect.home.local:/nfs/Emulation";
      fsType = "nfs";
    };

    networking.firewall.allowedTCPPorts = [
      romm.port
    ];
  };
}