{
  config,
  lib,
  ...
}:
{
  imports = [
    ../brew
  ];

  options.brooklyn.programs.colima = {
    enable = lib.mkEnableOption "colima";
  };

  config = lib.mkIf config.brooklyn.programs.colima.enable {
    homebrew.brews = [
      {
        name = "colima";
        restart_service = "changed";
        start_service = true;
      }
    ];

    home-manager.users.${config.common.username} =
      { config, lib, ... }:
      {
        home.activation.colimaDefault = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          run mkdir -p ${config.home.homeDirectory}/.colima/default && \
              cp -n ${./config/default/colima.yaml} ${config.home.homeDirectory}/.colima/default/colima.yaml && \
              chmod -R u+w ${config.home.homeDirectory}/.colima
        '';
      };
  };
}
