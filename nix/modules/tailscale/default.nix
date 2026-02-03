{
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
}
