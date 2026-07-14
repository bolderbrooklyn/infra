{
  config,
  lib,
  ...
}:
let
  syncthing = {
    guiPort = 8384;

    devices = {
      archaludon = "YIWUBZT-AURZU45-CY7IOO4-QXDS3RA-4HQ76EW-O6PUIT4-XOCVBVO-6UE4OAV";
      frosmoth = "FZ7RMRL-63TTPTJ-TST5N3L-OZYR3A5-MHCD3PF-O7P4LRE-DCVELUQ-7XIY6QN";
      miraidon = "YSTLBUH-WNBOF32-L4HXMGH-D7SQTJ5-ZWFWX2B-L6O5DN3-N2TSNSD-7DESKAB";
      xerneas = "6YQUA3X-4I57UQW-Z7XB3F7-ZZONOQK-3PPAQ3M-6BBREO6-GASPHXM-YEFSTQA";
    };
  };
in
{
  options.brooklyn.programs.syncthing.enable = lib.mkEnableOption "syncthing" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.syncthing.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      guiAddress = "0.0.0.0:${toString syncthing.guiPort}";

      settings = {
        devices = builtins.mapAttrs (name: id: {
          inherit id;
          compression = "always";

          addresses = [
            "dynamic"
            "quic://${name}.anteater-wall.ts.net:22000"
            "tcp://${name}.anteater-wall.ts.net:22000"
          ];
        }) syncthing.devices;

        options = {
          globalAnnounceEnabled = false;
          relaysEnabled = false;
          localAnnounceEnabled = true;
          urAccepted = -1;
        };
      };
    };

    networking.firewall.allowedTCPPorts = [ syncthing.guiPort ];
  };
}