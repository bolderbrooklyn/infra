{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";

    users.${config.common.username} =
      { config, ... }:
      {
        home.stateVersion = "25.05";

        home.packages = with pkgs; [
          httpie
          pkg-config
        ];

        programs = {
          btop = {
            enable = true;

            settings = {
              vim_keys = true;
            };
          };

          fd = {
            enable = true;
            hidden = true;

            ignores = [
              "*.app/"
              "*.photoslibrary/"
              ".Trash/"
              ".aitk/"
              ".azure/"
              ".cache/"
              ".cargo/"
              ".colima/_lima/"
              ".direnv/"
              ".docker/"
              ".gem/"
              ".git/"
              ".jj/"
              ".lmstudio/"
              ".local/share"
              ".local/state"
              ".mono/"
              ".npm/"
              ".pytest_cache/"
              ".rustup/"
              ".stfolder/"
              ".venv/"
              ".vscode/extensions/"
              ".yarn/"
              "Library/"
              "__pycache__/"
              "cache/"
              "node_modules/"
              "out/"
              "refs/"
              "tmp/"
            ];
          };

          fzf = {
            enable = true;

            defaultCommand = "fd --type f --hidden";
            changeDirWidgetCommand = "fd --type d --hidden";
          };

          gpg.enable = true;

          home-manager.enable = true;

          ripgrep.enable = true;

          ssh = {
            enable = true;
          }
          // lib.optionalAttrs (builtins.hasAttr "enableDefaultConfig" config.programs.ssh) {
            enableDefaultConfig = false;
          };

          zoxide.enable = true;
        };

        services.gpg-agent = {
          enable = true;
          pinentry.package = lib.mkIf pkgs.stdenv.isDarwin pkgs.pinentry_mac;
        };

        xdg.enable = true;
      };
  };
}
