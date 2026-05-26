{ config, ... }:
let
  kalmiya = {
    name = "kalmiya";
    stateDir = "/var/lib/kalmiya";
    configDir = "${kalmiya.stateDir}/config";
    workspaceDir = "${kalmiya.stateDir}/workspace";
    authProfileSecretDir = "${kalmiya.stateDir}/auth-profile-secrets";
    gatewayPort = 18789;
    bridgePort = 18790;
  };
in
{
  imports = [ ../podman ];

  systemd.tmpfiles.rules = [
    "d ${kalmiya.stateDir} 0755 0 0 - -"
    "d ${kalmiya.configDir} 0755 0 0 - -"
    "d ${kalmiya.workspaceDir} 0755 0 0 - -"
    "d ${kalmiya.authProfileSecretDir} 0755 0 0 - -"
  ];

  virtualisation.oci-containers.containers."${kalmiya.name}" = {
    image = "ghcr.io/openclaw/openclaw:latest";
    autoStart = true;
    pull = "newer";

    ports = [
      "${toString kalmiya.gatewayPort}:${toString kalmiya.gatewayPort}"
      "${toString kalmiya.bridgePort}:${toString kalmiya.bridgePort}"
    ];

    volumes = [
      "${kalmiya.configDir}:/home/node/.openclaw"
      "${kalmiya.workspaceDir}:/home/node/.openclaw/workspace"
      "${kalmiya.authProfileSecretDir}:/home/node/.config/openclaw"
    ];

    environment = {
      TZ = config.time.timeZone;
      HOME = "/home/node";
      OPENCLAW_HOME = "/home/node";
      OPENCLAW_STATE_DIR = "/home/node/.openclaw";
      OPENCLAW_CONFIG_PATH = "/home/node/.openclaw/openclaw.json";
      OPENCLAW_CONFIG_DIR = "/home/node/.openclaw";
      OPENCLAW_WORKSPACE_DIR = "/home/node/.openclaw/workspace";
      OPENCLAW_DISABLE_BONJOUR = "1";
      TERM = "xterm-256color";
    };

    extraOptions = [
      "--init"
      "--cap-drop=NET_RAW"
      "--cap-drop=NET_ADMIN"
      "--security-opt=no-new-privileges=true"
      "--add-host=host.docker.internal:host-gateway"
    ];

    cmd = [
      "node"
      "dist/index.js"
      "gateway"
      "--bind"
      "lan"
      "--port"
      "18789"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    kalmiya.gatewayPort
  ];
}
