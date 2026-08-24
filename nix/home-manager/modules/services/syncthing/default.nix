{
  config,
  lib,
  ...
}:
{
  options.brooklyn.services.syncthing = {
    enable = lib.mkEnableOption "syncthing";

    guiPort = lib.mkOption {
      type = lib.types.int;
      default = 8384;
    };

    devices = lib.mkOption {
      default = { };
      description = ''
        Peers/devices which Syncthing should communicate with, keyed by
        hostname with the device ID as the value.
      '';
      example = lib.literalExpression ''
        {
          tinkaton = "7CFNTQM-IMTJBHJ-3UWRDIU-ZGQJFR6-VCXZ3NB-XUH3KZO-N52ITXR-LAIYUAU";
        }
      '';
      type = lib.types.attrsOf lib.types.str;
    };
  };

  config.services.syncthing = {
    inherit (config.brooklyn.services.syncthing) enable;

    guiAddress = "127.0.0.1:${toString config.brooklyn.services.syncthing.guiPort}";

    settings.devices = builtins.mapAttrs (name: id: {
      inherit id;
      compression = "always";

      addresses = [
        "dynamic"
        "quic://${name}.anteater-wall.ts.net:22000"
        "tcp://${name}.anteater-wall.ts.net:22000"
      ];
    }) config.brooklyn.services.syncthing.devices;

    settings.options = {
      globalAnnounceEnabled = false;
      relaysEnabled = false;
      localAnnounceEnabled = true;
      urAccepted = -1;
    };

    tray.enable = config.brooklyn.gui.enable;
  };
}
