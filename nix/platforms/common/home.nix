{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.${config.common.username} = {
    home.stateVersion = "25.05";

    home.packages = with pkgs; [
      httpie
    ];

    programs.btop = {
      enable = true;

      settings = {
        vim_keys = true;
      };
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

    programs.fzf = {
      enable = true;

      defaultCommand = "fd --type f --hidden";
      changeDirWidgetCommand = "fd --type d --hidden";
    };

    programs.gemini-cli = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then null else pkgs.gemini-cli;

      settings = {
        preferredEditor = "zed";
        selectedAuthType = "oauth-personal";
      };
    };

    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentry.package = lib.mkIf pkgs.stdenv.isDarwin pkgs.pinentry_mac;
    };

    programs.home-manager.enable = true;

    programs.opencode = {
      enable = true;

      settings = {
        theme = "catppuccin";
      };
    };

    programs.ripgrep.enable = true;

    programs.ssh.enable = true;

    programs.tmux = {
      enable = true;

      clock24 = true;
      keyMode = "vi";
      mouse = true;
      shortcut = "a";

      extraConfig = ''
        set -g status-position top
      '';
    };

    programs.zoxide.enable = true;

    xdg.enable = true;
  };
}
