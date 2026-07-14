{
  config,
  lib,
  pkgs,
  ...
}:
let
  forgejo = {
    domain = "git.anteater-wall.ts.net";
    storageDir = "/mnt/genesect/forgejo";
    port = 3000;
  };
in
{
  options.brooklyn.programs.forgejo.enable = lib.mkEnableOption "forgejo" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.forgejo.enable {
    services.forgejo = {
      enable = true;
      package = pkgs.forgejo;
      repositoryRoot = "${forgejo.storageDir}/repositories";

      dump = {
        enable = true;
        backupDir = "${forgejo.storageDir}/backups";
      };

      lfs = {
        enable = true;
        contentDir = "${forgejo.storageDir}/lfs";
      };

      settings = {
        session.COOKIE_SECURE = true;
        server = {
          DISABLE_SSH = true;
          DOMAIN = forgejo.domain;
          HTTP_PORT = forgejo.port;
          ROOT_URL = "https://${forgejo.domain}/";
        };
        service.DISABLE_REGISTRATION = true;
      };
    };

    services.gitea-actions-runner = {
      package = pkgs.forgejo-runner;

      instances.tinkaton = {
        enable = true;
        name = "tinkaton";
        labels = [
          "ubuntu-latest:docker://ghcr.io/catthehacker/ubuntu:act-latest"
        ];
        url = "http://localhost:3000";
        tokenFile = config.age.secrets."gitea-actions-runner-forgejo".path;
      };

      instances.tinkaton-codeberg = {
        enable = true;
        name = "tinkaton-codeberg";
        labels = [
          "ubuntu-latest:docker://ghcr.io/catthehacker/ubuntu:act-latest"
        ];

        settings.runner.capacity = 3;

        url = "https://codeberg.org";
        tokenFile = config.age.secrets."gitea-actions-runner-codeberg".path;
      };

    };

    networking.firewall = {
      allowedTCPPorts = [ forgejo.port ];
      trustedInterfaces = [ "podman+" ]; # allow cache actions
    };

    fileSystems."${forgejo.storageDir}" = {
      device = "genesect.home.local:/nfs/Forgejo";
      fsType = "nfs";
      options = [ "noatime" ];
    };

    systemd.tmpfiles.rules = [
      "d ${forgejo.storageDir}/backups 0755 forgejo forgejo -"
      "d ${forgejo.storageDir}/lfs 0755 forgejo forgejo -"
      "d ${forgejo.storageDir}/repositories 0755 forgejo forgejo -"
    ];
  };
}