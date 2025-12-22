let
  unmanic = {
    name = "unmanic";
    uid = 20200;
    port = 8888;
  };
in
{
  imports = [ ../podman ];

  users.groups.${unmanic.name} = {
    gid = unmanic.uid;
  };

  users.users.${unmanic.name} = {
    inherit (unmanic) uid;
    group = unmanic.name;
    isSystemUser = true;
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/${unmanic.name} 0755 ${unmanic.name} ${unmanic.name} -"
    "d /tmp/${unmanic.name} 0755 ${unmanic.name} ${unmanic.name} -"
  ];

  virtualisation.oci-containers.containers.${unmanic.name} = {
    image = "josh5/unmanic:latest";
    autoStart = true;
    pull = "newer";

    devices = [
      "/dev/dri:/dev/dri"
    ];

    ports = [ "${builtins.toString unmanic.port}:${builtins.toString unmanic.port}" ];

    volumes = [
      "/var/lib/${unmanic.name}:/config"
      "/tmp/${unmanic.name}:/tmp"
      "/mnt/genesect/media:/library"
    ];
  };

  networking.firewall.allowedTCPPorts = [ unmanic.port ];
}
