{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
    extraSetFlags = [
      "--exit-node-allow-lan-access=true"
    ];
  };
}
