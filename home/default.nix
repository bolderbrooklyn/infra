{ config, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.${config.system.primaryUser} =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      signing_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAnSncawa7Y3U7/ZUkqnXLrAgJ5mxNLLKOgM20+dsV+";
    in
    {
      imports = [
        ./aliases/default.nix
      ];

      home.stateVersion = "25.05";

      home.file = {
        ".config/git/allowed_signers" = {
          text = "jesse@jbhannah.net ${signing_key}";
        };

        ".config/nvim" = {
          source = ./dotfiles/.config/nvim;
          recursive = true;
        };
      };

      home.packages = with pkgs; [
        cascadia-code
        devenv
        httpie
        k9s
        kubectl
        kubernetes-helm
        nil
        nixd
        nixfmt-rfc-style
        ruby
        tmux
      ];

      programs.bat.enable = true;

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.eza = {
        enable = true;
        extraOptions = [ "--group-directories-first" ];
        git = true;
      };

      programs.fd = {
        enable = true;
        hidden = true;

        ignores = [
          ".direnv/"
          ".git/"
        ];
      };

      programs.fish = {
        enable = true;

        functions = {
          fish_greeting = "";
        };

        interactiveShellInit = ''
          fish_vi_key_bindings
        '';
      };

      programs.fzf = {
        enable = true;

        defaultCommand = "fd --type f --hidden";
        changeDirWidgetCommand = "fd --type d --hidden";
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
          gpg.ssh.program = lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
          init.defaultBranch = "trunk";
          log.showSignature = true;
          merge.conflictStyle = "zdiff3";
          pull.rebase = true;
        };
      };

      programs.home-manager.enable = true;

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;

        extraPackages = with pkgs; [
          ast-grep
          imagemagick
          lazygit
          lua5_1
          luarocks
          lynx
          markdownlint-cli2
          nil
          shfmt
          stylua
          wget
        ];

        extraLuaPackages =
          ps: with ps; [
            tiktoken_core
          ];
      };

      programs.ripgrep.enable = true;
      programs.ripgrep-all.enable = true;

      programs.ssh = {
        enable = true;
        forwardAgent = true;
      };

      programs.starship = {
        enable = true;

        settings = {
          shell = {
            disabled = false;
            fish_indicator = "🐟";
          };
        };
      };

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

      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        pinentry.package = lib.mkIf pkgs.stdenv.isDarwin pkgs.pinentry_mac;
      };
    };
}
