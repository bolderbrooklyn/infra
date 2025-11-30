{ pkgs, ... }:
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
