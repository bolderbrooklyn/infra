{ config, inputs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.${config.common.username} =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      signing_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAnSncawa7Y3U7/ZUkqnXLrAgJ5mxNLLKOgM20+dsV+";
    in
    {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
        ./aliases/default.nix
      ];

      home.stateVersion = "25.05";

      home.file = {
        ".config/git/allowed_signers" = {
          text = "jesse@jbhannah.net ${signing_key}";
        };
      };

      home.packages = with pkgs; [
        devenv
        httpie
        kubectl
        kubernetes-helm
      ];

      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      programs.bat.enable = true;

      programs.btop = {
        enable = true;

        settings = {
          vim_keys = true;
        };
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;

        config = {
          hide_env_diff = true;
          strict_env = true;
          warn_timeout = "20s";
        };
      };

      programs.eza = {
        enable = true;
        extraOptions = [
          "--group-directories-first"
          "--group"
        ];
        git = true;
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

      programs.fish = {
        enable = true;

        functions = {
          fish_greeting = "";
        };

        interactiveShellInit = ''
          string match -q "$TERM" alacritty; and not set -q TMUX; and exec tmux new-session -As0
          fish_vi_key_bindings
        '';
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

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;

        extensions = with pkgs; [
          gh-copilot
        ];
      };

      programs.git = {
        enable = true;
        lfs.enable = true;

        userEmail = "jesse@jbhannah.net";
        userName = "Jesse Brooklyn Hannah";

        signing = {
          key = signing_key;
          format = "ssh";
          signByDefault = true;
          signer = "ssh-keygen";
        };

        delta = {
          enable = true;

          options = {
            line-numbers = true;
            navigate = true;
            side-by-side = true;
          };
        };

        extraConfig = {
          fetch.prune = true;
          gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
          init.defaultBranch = "trunk";
          log.showSignature = true;
          merge.conflictStyle = "zdiff3";
          pull.rebase = true;
        };
      };

      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        pinentry.package = lib.mkIf pkgs.stdenv.isDarwin pkgs.pinentry_mac;
      };

      programs.home-manager.enable = true;

      programs.jujutsu = {
        enable = true;

        settings = {
          user.email = "jesse@jbhannah.net";
          user.name = "Jesse Brooklyn Hannah";

          signing = {
            behavior = "own";
            backend = "ssh";
            key = signing_key;
            allowed-signers = "${config.home.homeDirectory}/.config/git/allowed_signers";
          };
        };
      };

      programs.lazygit = {
        enable = true;

        settings = {
          git.mainBranches = [
            "trunk"
            "main"
            "master"
          ];
        };
      };

      programs.k9s.enable = true;

      programs.nushell = {
        enable = true;
      };

      programs.opencode = {
        enable = true;

        settings = {
          theme = "catppuccin";
        };
      };

      programs.ripgrep.enable = true;

      programs.ssh.enable = true;

      programs.starship = {
        enable = true;

        settings = {
          direnv.disabled = false;
          gcloud.disabled = true;
          nix_shell.symbol = " ";
          scala.detect_folders = [ ];
          shell.disabled = false;
        };
      };

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

      programs.zsh = {
        enable = true;

        autocd = true;
        defaultKeymap = "viins";

        history = {
          append = true;
          extended = true;
          ignoreAllDups = true;
        };

        syntaxHighlighting = {
          enable = true;
        };
      };

      xdg.enable = true;
    };
}
