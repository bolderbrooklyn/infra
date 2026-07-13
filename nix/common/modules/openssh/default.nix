{
  config,
  lib,
  ...
}:
{
  options.brooklyn.programs.openssh.enable = lib.mkEnableOption "openssh" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.openssh.enable {
    services.openssh = {
      extraConfig = ''
        PasswordAuthentication no
        PermitRootLogin no
      '';
    };
  };
}
