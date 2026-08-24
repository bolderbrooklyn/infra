{ config, lib, ... }:
{
  options.brooklyn.services.syncthing = {
    guiPort = lib.mkOption {
      type = lib.types.int;
      default = 8384;
    };
  };

  config.services.syncthing = {
    guiAddress = "0.0.0.0:${toString config.brooklyn.services.syncthing.guiPort}";

    settings.options = {
      globalAnnounceEnabled = false;
      relaysEnabled = false;
      localAnnounceEnabled = true;
      urAccepted = -1;
    };
  };
}
