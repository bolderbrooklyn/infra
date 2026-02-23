{ config, pkgs, ... }:
{
  imports = [
    ../../../common/modules/docker
  ];

  home-manager.users.${config.common.username} =
    { config, lib, ... }:
    let
      colimaLogPath = "${config.home.homeDirectory}/.config/colima/colima.log";
    in
    {
      home.packages = with pkgs; [
        colima
      ];

      launchd.agents.colima = {
        enable = true;
        config = {
          Label = "org.nix-community.home.colima";
          ProgramArguments = [
            "${pkgs.colima}/bin/colima"
            "start"
            "--foreground"
          ];
          KeepAlive = true;
          EnvironmentVariables = {
            PATH =
              with pkgs;
              lib.makeBinPath [
                colima
                lima
                docker
                "/usr/local"
                "/usr"
              ];
          };
          RunAtLoad = true;
          StandardOutPath = colimaLogPath;
          StandardErrorPath = colimaLogPath;
          WorkingDirectory = config.home.homeDirectory;
        };
      };

      home.activation.colimaDefault = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p ${config.home.homeDirectory}/.config/colima/default && \
            cp -n ${./config/default/colima.yaml} ${config.home.homeDirectory}/.config/colima/default/colima.yaml && \
            chmod -R u+w ${config.home.homeDirectory}/.config/colima
      '';
    };
}
