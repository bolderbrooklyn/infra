{
  config,
  lib,
  ...
}:
let
  media = {
    name = "media";
    uid = 20100;
  };
in
{
  options.brooklyn.programs.media.enable = lib.mkEnableOption "shared media user, group, and NFS mount" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.media.enable {
    users.groups.media = {
      gid = media.uid;
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
  };
}