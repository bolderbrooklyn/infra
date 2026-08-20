{ lib, ... }: {
  imports = [
    ./modules/ghostty
  ];

  options.brooklyn.gui.enable = lib.mkEnableOption "gui";
}
