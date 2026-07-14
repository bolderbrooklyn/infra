{
  config,
  lib,
  ...
}:
let
  lazylibrarian = {
    name = "lazylibrarian";
    uid = 20300;
    baseDir = "/var/lib/lazylibrarian";

    webPort = 5299;
  };
in
{
  options.brooklyn.programs.lazylibrarian.enable = lib.mkEnableOption "lazylibrarian" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.lazylibrarian.enable {
    users.groups.${lazylibrarian.name} = {
      gid = lazylibrarian.uid;
    };

    users.users.${lazylibrarian.name} = {
      inherit (lazylibrarian) uid;
      isSystemUser = true;
      group = lazylibrarian.name;
    };

    systemd.tmpfiles.rules = [
      "d ${lazylibrarian.baseDir} 0755 ${lazylibrarian.name} ${lazylibrarian.name} -"
    ];

    virtualisation.oci-containers.containers.lazylibrarian = {
      image = "lscr.io/linuxserver/lazylibrarian:latest";
      autoStart = true;
      pull = "newer";

      ports = [
        "${toString lazylibrarian.webPort}:5299"
      ];

      volumes = [
        "${lazylibrarian.baseDir}:/config"
        "/mnt/genesect/media/Downloads:/downloads"
        "/mnt/genesect/media/Books:/books"
      ];

      environment = {
        PUID = toString lazylibrarian.uid;
        PGID = toString lazylibrarian.uid;
        TZ = config.time.timeZone;
        DOCKER_MODS = "linuxserver/mods:universal-calibre|linuxserver/mods:lazylibrarian-ffmpeg";
      };
    };

    networking.firewall.allowedTCPPorts = [
      lazylibrarian.webPort
    ];
  };
}