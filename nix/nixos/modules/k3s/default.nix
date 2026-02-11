{
  networking.firewall.allowedTCPPorts = [
    6443
  ];

  services.k3s = {
    enable = true;
    role = "server";

    manifests = {
      postgresql.content = [
        {
          apiVersion = "v1";
          kind = "Service";
          metadata.name = "postgresql";
          spec = {
            clusterIP = "None";
            ports = [
              {
                port = 5432;
              }
            ];
          };
        }
        {
          apiVersion = "v1";
          kind = "Endpoints";
          metadata.name = "postgresql";
          subsets = [
            {
              addresses = [
                {
                  ip = "172.25.1.185";
                }
              ];
              ports = [
                {
                  port = 5432;
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
