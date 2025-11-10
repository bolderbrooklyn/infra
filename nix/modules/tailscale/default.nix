{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
    extraSetFlags = [
      "--exit-node-allow-lan-access=true"
      "--exit-node=us-sjc-wg-402.mullvad.ts.net."
    ];
  };
}
