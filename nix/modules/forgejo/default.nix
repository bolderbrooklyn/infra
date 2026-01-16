{ config, pkgs, ... }:
let
  forgejo = {
    domain = "forgejo.anteater-wall.ts.net";
    stateDir = "/mnt/genesect/forgejo";
    port = 3000;
  };
in
{
  services.forgejo = {
    enable = true;
    package = pkgs.forgejo;
    stateDir = forgejo.stateDir;
    dump.enable = true;
    lfs.enable = true;

    settings = {
      session.COOKIE_SECURE = true;
      server = {
        DISABLE_SSH = true;
        DOMAIN = forgejo.domain;
        HTTP_PORT = forgejo.port;
        ROOT_URL = "https://${forgejo.domain}/";
      };
    };
  };

  services.gitea-actions-runner = {
    instances = {
      tinkaton = {
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
  };

  networking.firewall.allowedTCPPorts = [ forgejo.port ];

  fileSystems."${forgejo.stateDir}" = {
    device = "genesect.home.local:/nfs/Forgejo";
    fsType = "nfs";
    options = [
      "noatime"
      "nodiratime"
    ];
  };
}
