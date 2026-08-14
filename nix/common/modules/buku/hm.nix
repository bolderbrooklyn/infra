{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.buku.enable = lib.mkEnableOption "buku";

  config = lib.mkIf config.brooklyn.programs.buku.enable {
    home.packages = with pkgs; [
      buku
    ];
  };
}
