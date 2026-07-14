{
  config,
  lib,
  pkgs,
  ...
}:
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
    craftyPort = 9443;
    bedrockPort = 19132;
    javaPorts = {
      from = 25500;
      to = 25600;
    };
    voicePorts = {
      from = 24400;
      to = 24500;
    };
  };
in
{
  options.brooklyn.programs.crafty.enable = lib.mkEnableOption "crafty";

  config = lib.mkIf config.brooklyn.programs.crafty.enable {
    environment.systemPackages = with pkgs; [
      ferium
    ];

    users.groups.crafty = {
      gid = crafty.uid;
    };

    users.users.crafty = {
      inherit (crafty) uid;

      isSystemUser = true;
      group = crafty.name;
    };

    systemd.tmpfiles.rules = [
      # "d ${crafty.baseDir} 0755 ${crafty.name} ${crafty.name} - -"
      # "d ${crafty.backupsDir} 0755 ${crafty.name} ${crafty.name} - -"
      # "d ${crafty.logsDir} 0755 ${crafty.name} ${crafty.name} - -"
      # "d ${crafty.serversDir} 0755 ${crafty.name} ${crafty.name} - -"
      # "d ${crafty.configDir} 0755 ${crafty.name} ${crafty.name} - -"
      # "d ${crafty.importDir} 0755 ${crafty.name} ${crafty.name} - -"
      "d ${crafty.baseDir} 0755 1000 0 - -"
      "d ${crafty.backupsDir} 0755 1000 0 - -"
      "d ${crafty.logsDir} 0755 1000 0 - -"
      "d ${crafty.serversDir} 0755 1000 0 - -"
      "d ${crafty.configDir} 0755 1000 0 - -"
      "d ${crafty.importDir} 0755 1000 0 - -"
    ];

    virtualisation.oci-containers.containers.crafty = {
      image = "arcadiatechnology/crafty-4:latest";
      autoStart = true;
      pull = "newer";

      ports = [
        "${toString crafty.dynmapPort}:${toString crafty.dynmapPort}/tcp" # dynmap
        "${toString crafty.craftyPort}:8443/tcp" # crafty
        "${toString crafty.bedrockPort}:${toString crafty.bedrockPort}/udp" # bedrock
        "${toString crafty.javaPorts.from}-${toString crafty.javaPorts.to}:${toString crafty.javaPorts.from}-${toString crafty.javaPorts.to}" # java
        "${toString crafty.voicePorts.from}-${toString crafty.voicePorts.to}:${toString crafty.voicePorts.from}-${toString crafty.voicePorts.to}/udp" # voice
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

    networking.firewall = {
      allowedTCPPorts = [
        crafty.dynmapPort
        crafty.craftyPort
      ];

      allowedTCPPortRanges = [
        crafty.javaPorts
      ];

      allowedUDPPorts = [
        crafty.bedrockPort
      ];

      allowedUDPPortRanges = [
        crafty.javaPorts
        crafty.voicePorts
      ];
    };
  };
}