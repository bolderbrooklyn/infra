{
  config,
  lib,
  ...
}:
{
  imports = [ ../media ];

  options.brooklyn.programs.audiobookshelf.enable = lib.mkEnableOption "audiobookshelf" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.audiobookshelf.enable {
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
  };
}