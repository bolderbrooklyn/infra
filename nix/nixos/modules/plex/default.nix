{ pkgs, ... }:
let
  media = {
    name = "media";
    uid = 20100;
  };
in
{
  environment.systemPackages = with pkgs; [ xteve ];

  systemd.services.xteve = {
    requires = [ "network.target" ];
    script = "${pkgs.xteve}/bin/xteve -port 34400";
    wantedBy = [ "multi-user.target" ];
  };

  networking.firewall.allowedTCPPorts = [ 34400 ];

  systemd.services.plex.requires = [ "mnt-genesect-media.mount" ];

  services = {
    plex = {
      enable = true;
      openFirewall = true;
    };

    tautulli = {
      enable = true;
      openFirewall = true;
    };
  };

  users.groups.media = {
    gid = media.uid;
    members = [ "plex" ];
  };

  users.users.media = {
    isSystemUser = true;
    inherit (media) uid;
    group = media.name;
  };

  fileSystems."/mnt/genesect/media" = {
    device = "genesect.home.local:/nfs/Media";
    fsType = "nfs";
    options = [
      "noatime"
      "nodiratime"
    ];
  };
}
