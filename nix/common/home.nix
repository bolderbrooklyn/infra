{
  config,
  lib,
  pkgs,
  agenix,
  ...
}:
let
  inherit (config.common) username;
in
{
  home-manager = {
    sharedModules = [
      agenix.homeManagerModules.default
    ];

    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";

    users.${username} =
      { config, ... }:
      {
        age.identityPaths = [
          "${config.home.homeDirectory}/.ssh/id_ed25519"
        ];

        home = {
          shellAliases = {
            l = "ls -alh";
          };

          stateVersion = "26.05";
          enableNixpkgsReleaseCheck = false;

          packages =
            with pkgs;
            [
              httpie
              pkg-config
            ]
            ++ [
              (agenix.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
                nix = pkgs.lix;
              })
            ];
        };

        programs = {
          home-manager.enable = true;

          ssh = {
            enable = true;
          }
          // lib.optionalAttrs (builtins.hasAttr "enableDefaultConfig" config.programs.ssh) {
            enableDefaultConfig = false;
          };

          zoxide.enable = true;
        };

        services.home-manager = {
          autoExpire.enable = true;
        };

        xdg = {
          enable = true;
          localBinInPath = true;
        };
      };
  };
}
