let
  syncthing = {
    port = 8384;
  };
in
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:${builtins.toString syncthing.port}";

    settings = {
      devices = {
        archaludon = {
          id = "YIWUBZT-AURZU45-CY7IOO4-QXDS3RA-4HQ76EW-O6PUIT4-XOCVBVO-6UE4OAV";
          compression = "always";

          addresses = [
            "dynamic"
            "quic://archaludon.anteater-wall.ts.net:22000"
            "tcp://archaludon.anteater-wall.ts.net:22000"
          ];
        };

        frosmoth = {
          id = "FZ7RMRL-63TTPTJ-TST5N3L-OZYR3A5-MHCD3PF-O7P4LRE-DCVELUQ-7XIY6QN";
          compression = "always";

          addresses = [
            "dynamic"
            "quic://frosmoth.anteater-wall.ts.net:22000"
            "tcp://frosmoth.anteater-wall.ts.net:22000"
          ];
        };

        miraidon = {
          id = "YSTLBUH-WNBOF32-L4HXMGH-D7SQTJ5-ZWFWX2B-L6O5DN3-N2TSNSD-7DESKAB";
          compression = "always";

          addresses = [
            "dynamic"
            "quic://miraidon.anteater-wall.ts.net:22000"
            "tcp://miraidon.anteater-wall.ts.net:22000"
          ];
        };
      };

      options = {
        globalAnnounceEnabled = false;
        relaysEnabled = false;
        localAnnounceEnabled = true;
        urAccepted = -1;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ syncthing.port ];
}
