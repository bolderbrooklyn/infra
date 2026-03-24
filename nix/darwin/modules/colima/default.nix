{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../../common/modules/docker
  ];

  options.brooklyn.programs.colima = {
    enable = lib.mkEnableOption "colima";
  };

  config = lib.mkIf config.brooklyn.programs.colima.enable {
    nix-homebrew.taps = {
      "slp/homebrew-krunkit" = inputs.homebrew-krunkit;
    };

    homebrew.brews = [
      "dtc"
      "krunkit"
      "libepoxy"
      "molten-vk"
      "libkrun-efi"
      "virglrenderer"
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
              PATH = lib.makeBinPath (
                with pkgs;
                [
                  colima
                  lima
                  docker
                  "/usr/local"
                  "/usr"
                ]
              );
              XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
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
  };
}
