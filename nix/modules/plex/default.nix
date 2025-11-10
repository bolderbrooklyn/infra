let
  media = {
    name = "media";
    uid = 20100;
  };
in
{
  services = {
    plex = {
      enable = true;
      openFirewall = true;
    };

    # ombi = {
    #   enable = true;
    #   openFirewall = true;
    # };

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
