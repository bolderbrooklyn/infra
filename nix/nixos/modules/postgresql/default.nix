{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.postgresql.enable = lib.mkEnableOption "postgresql" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.postgresql.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_18;
      enableTCPIP = true;
    };

    networking.firewall.allowedTCPPorts = [
      5432
    ];
  };
}