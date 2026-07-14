{
  config,
  lib,
  ...
}:
{
  imports = [ ../media ];

  options.brooklyn.programs.navidrome.enable = lib.mkEnableOption "navidrome";

  config = lib.mkIf config.brooklyn.programs.navidrome.enable {
    services.navidrome = {
      enable = true;
      group = "media";
      settings.MusicFolder = "/mnt/genesect/media/Music";
    };

    systemd.services.navidrome.after = [ "mnt-genesect-media.mount" ];
    systemd.services.navidrome.requires = [ "mnt-genesect-media.mount" ];
  };
}