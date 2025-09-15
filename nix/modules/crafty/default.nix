{ config, ... }:
let
  crafty = {
    name = "crafty";
    uid = 30100;
    baseDir = "/var/lib/crafty";
    backupsDir = "${crafty.baseDir}/backups";
    logsDir = "${crafty.baseDir}/logs";
    serversDir = "${crafty.baseDir}/servers";
    configDir = "${crafty.baseDir}/config";
    importDir = "${crafty.baseDir}/import";

    dynmapPort = 8123;
    craftyPort = 8443;
    bedrockPort = 19132;
    javaPorts = {
      from = 25500;
      to = 25600;
    };
  };
in
{
  imports = [ ../podman ];

  users.groups.crafty = {
    gid = crafty.uid;
  };

  users.users.crafty = {
    isSystemUser = true;
    uid = crafty.uid;
    group = crafty.name;
  };

  systemd.tmpfiles.rules = [
    "d ${crafty.baseDir} 0755 ${crafty.name} ${crafty.name} - -"
    "d ${crafty.backupsDir} 0755 ${crafty.name} ${crafty.name} - -"
    "d ${crafty.logsDir} 0755 ${crafty.name} ${crafty.name} - -"
    "d ${crafty.serversDir} 0755 ${crafty.name} ${crafty.name} - -"
    "d ${crafty.configDir} 0755 ${crafty.name} ${crafty.name} - -"
    "d ${crafty.importDir} 0755 ${crafty.name} ${crafty.name} - -"
  ];

  virtualisation.oci-containers.containers.crafty = {
    image = "arcadiatechnology/crafty-4:latest";
    autoStart = true;
    pull = "newer";

    ports = [
      "${builtins.toString crafty.dynmapPort}:${builtins.toString crafty.dynmapPort}/tcp" # dynmap
      "${builtins.toString crafty.craftyPort}:${builtins.toString crafty.craftyPort}/tcp" # crafty
      "${builtins.toString crafty.bedrockPort}:${builtins.toString crafty.bedrockPort}/udp" # bedrock
      "${builtins.toString crafty.javaPorts.from}-${builtins.toString crafty.javaPorts.to}:${builtins.toString crafty.javaPorts.from}-${builtins.toString crafty.javaPorts.to}" # java
    ];

    volumes = [
      "${crafty.backupsDir}:/crafty/backups"
      "${crafty.logsDir}:/crafty/logs"
      "${crafty.serversDir}:/crafty/servers"
      "${crafty.configDir}:/crafty/app/config"
      "${crafty.importDir}:/crafty/import"
    ];

    environment = {
      TZ = config.time.timeZone;
    };
  };

  networking.firewall.allowedTCPPorts = [
    crafty.dynmapPort
    crafty.craftyPort
  ];

  networking.firewall.allowedTCPPortRanges = [
    crafty.javaPorts
  ];

  networking.firewall.allowedUDPPorts = [
    crafty.bedrockPort
  ];

  networking.firewall.allowedUDPPortRanges = [
    crafty.javaPorts
  ];
}
