{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.tailscale.enable = lib.mkEnableOption "tailscale";

  config = lib.mkIf config.brooklyn.programs.tailscale.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "both";

      extraSetFlags = [
        "--exit-node-allow-lan-access=true"
      ];
    };

    systemd.services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];
  };
}