{ config, pkgs, ... }:
let
  forgejo = {
    domain = "git.anteater-wall.ts.net";
    storageDir = "/mnt/genesect/forgejo";
    port = 3000;
  };
in
{
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
        "debian-latest:docker://node:lts-bullseye"
        "ubuntu-latest:docker://node:lts-bullseye"
      ];
      url = "http://localhost:3000";
      tokenFile = config.age.secrets."gitea-actions-runner-forgejo".path;
    };

  };

  networking.firewall.allowedTCPPorts = [ forgejo.port ];

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
}
