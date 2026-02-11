{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    enableTCPIP = true;
  };

  networking.firewall.allowedTCPPorts = [
    5432
  ];
}
