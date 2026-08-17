{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.buku.enable = lib.mkEnableOption "buku";

  config = lib.mkIf config.brooklyn.programs.buku.enable {
    home-manager.users.${config.common.username} = {
      home.packages = with pkgs; [
        buku
      ];
    };
  };
}
