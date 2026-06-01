{ config, ... }:
let
  inherit (config.common) username;
in
{
  home-manager.users.${username} = {
    home.shellAliases = {
      find = "fd";
    };

    programs.fd = {
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
  };
}
