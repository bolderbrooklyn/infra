{ lib, ... }: {
  imports = [
    ./modules/programs
  ];

  options.brooklyn.gui.enable = lib.mkEnableOption "gui";
}
