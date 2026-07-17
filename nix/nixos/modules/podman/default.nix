{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.podman.enable = lib.mkEnableOption "podman" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.podman.enable {
    virtualisation = {
      containers.enable = true;
      containers.containersConf.settings.engine.num_locks = 8192;

      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      oci-containers.backend = "podman";
    };

    networking.firewall.interfaces."podman*" = {
      allowedUDPPorts = [ 53 ];
      allowedTCPPorts = [ 53 ];
    };
  };
}
