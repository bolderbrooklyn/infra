{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    enableTCPIP = true;

    authentication = ''
      host all all 10.42.0.0/24 scram-sha-256
    '';
  };

  networking.firewall.allowedTCPPorts = [
    5432
  ];
}
