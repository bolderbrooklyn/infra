{ config, lib, ... }:
{
  options.brooklyn.programs.qutebrowser.enable = lib.mkEnableOption "qutebrowser";

  config = lib.mkIf config.brooklyn.programs.qutebrowser.enable {
    programs.qutebrowser = { };
  };
}
