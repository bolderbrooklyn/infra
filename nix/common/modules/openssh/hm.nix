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
    # SSH server hardening is a NixOS-only concern; no HM-side config needed.
  };
}
