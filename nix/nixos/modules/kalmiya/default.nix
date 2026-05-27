{ inputs, pkgs, ... }:
let
  user = "kalmiya";
  homeDir = "/var/lib/${user}";
  openclawDir = "${homeDir}/.openclaw";
  workspaceDir = "${openclawDir}/workspace";
  quadletDir = "${homeDir}/.config/containers/systemd";
  gatewayPort = 18789;
  bridgePort = 18790;

  openclawJson = pkgs.writeText "openclaw.json" (builtins.toJSON {
    gateway = {
      mode = "local";
      controlUi = {
        allowedOrigins = [
          "http://127.0.0.1:${toString gatewayPort}"
          "http://localhost:${toString gatewayPort}"
        ];
      };
    };
  });

  openclawContainer = pkgs.writeText "openclaw.container" ''
    [Unit]
    Description=OpenClaw Gateway
    After=network-online.target
    Wants=network-online.target

    [Container]
    Image=ghcr.io/openclaw/openclaw:latest
    ContainerName=openclaw
    PublishPort=127.0.0.1:${toString gatewayPort}:${toString gatewayPort}
    PublishPort=127.0.0.1:${toString bridgePort}:${toString bridgePort}
    Volume=%h/.openclaw:/home/node/.openclaw:Z
    Volume=%h/.openclaw/workspace:/home/node/.openclaw/workspace:Z
    Environment=OPENCLAW_NO_RESPAWN=1
    Environment=OPENCLAW_GATEWAY_BIND=lan
    EnvironmentFile=%h/.openclaw/.env
    Pull=newer

    [Service]
    Restart=on-failure
    TimeoutStartSec=300

    [Install]
    WantedBy=default.target
  '';
in
{
  imports = [ ../podman ];

  nixpkgs.overlays = [ inputs.nix-openclaw.overlays.default ];

  users.users.${user} = {
    isSystemUser = true;
    home = homeDir;
    createHome = true;
    group = user;
    linger = true;
    subUidRanges = [{ startUid = 300000; count = 65536; }];
    subGidRanges = [{ startGid = 300000; count = 65536; }];
    shell = pkgs.bash;
  };

  users.groups.${user} = {};

  systemd.tmpfiles.rules = [
    "d ${homeDir} 0750 ${user} ${user} - -"
    "d ${openclawDir} 0750 ${user} ${user} - -"
    "d ${workspaceDir} 0750 ${user} ${user} - -"
    "d ${homeDir}/.config 0750 ${user} ${user} - -"
    "d ${homeDir}/.config/containers 0750 ${user} ${user} - -"
    "d ${quadletDir} 0750 ${user} ${user} - -"
  ];

  environment.systemPackages = [ pkgs.openclaw ];

  systemd.services."setup-openclaw" = {
    description = "Set up OpenClaw rootless podman for ${user}";
    after = [ "network.target" ];
    before = [ "systemd-user-sessions.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      # Generate gateway token if missing
      if [ ! -f "${openclawDir}/.env" ]; then
        TOKEN=$(cat /proc/sys/kernel/random/uuid)
        echo "OPENCLAW_GATEWAY_TOKEN=$TOKEN" > "${openclawDir}/.env"
        chown ${user}:${user} "${openclawDir}/.env"
        chmod 600 "${openclawDir}/.env"
      fi

      # Create openclaw.json if missing (user may customize)
      if [ ! -f "${openclawDir}/openclaw.json" ]; then
        cp "${openclawJson}" "${openclawDir}/openclaw.json"
        chown ${user}:${user} "${openclawDir}/openclaw.json"
        chmod 640 "${openclawDir}/openclaw.json"
      fi

      # Always update the Quadlet file (infrastructure, not user config)
      cp "${openclawContainer}" "${quadletDir}/openclaw.container"
      chown ${user}:${user} "${quadletDir}/openclaw.container"
      chmod 644 "${quadletDir}/openclaw.container"

      # Wait for user systemd manager to be ready
      for i in $(seq 1 30); do
        if systemctl --machine=${user}@ --user is-system-running &>/dev/null; then
          break
        fi
        sleep 1
      done

      # Reload to pick up Quadlet, then enable and start
      systemctl --machine=${user}@ --user daemon-reload
      systemctl --machine=${user}@ --user enable openclaw.service
      systemctl --machine=${user}@ --user --no-block start openclaw.service || true
    '';
  };

  networking.firewall.allowedTCPPorts = [ gatewayPort ];
}
