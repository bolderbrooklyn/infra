{
  config,
  inputs,
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

    extraSpecialArgs = {
      inherit (inputs) catppuccin llm-agents nix-obsidian-extensions;
    };

    backupFileExtension = "hm-backup";

    users.${username} =
      { config, ... }:
      {
        imports = [
          ../home-manager/users/brooklyn
        ];

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
          ssh = {
            enable = true;
          }
          // lib.optionalAttrs (builtins.hasAttr "enableDefaultConfig" config.programs.ssh) {
            enableDefaultConfig = false;
          };
        };
      };
  };
}
