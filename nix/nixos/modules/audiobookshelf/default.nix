{
  services.audiobookshelf = {
    enable = true;
    group = "media";
    host = "0.0.0.0";
    port = 8280;
    openFirewall = true;
  };

  systemd.services.audiobookshelf = {
    after = [ "mnt-genesect-media.mount" ];
    requires = [ "mnt-genesect-media.mount" ];
  };
}
