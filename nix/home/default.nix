{ config, inputs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.${config.system.primaryUser} =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      _1password_ssh_agent_sock = "${config.home.homeDirectory}/${
        if pkgs.stdenv.isDarwin then "Library/Group Containers/2BUA8C4S2C.com.1password/t" else ".1password"
      }/agent.sock";

      signing_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAnSncawa7Y3U7/ZUkqnXLrAgJ5mxNLLKOgM20+dsV+";
    in
    {
      imports = [
        inputs._1password-shell-plugins.hmModules.default
        inputs.catppuccin.homeModules.catppuccin
        ./aliases/default.nix
      ];

      home.stateVersion = "25.05";

      home.sessionVariables = {
        SSH_AUTH_SOCK = _1password_ssh_agent_sock;
      };

      home.file = {
        ".config/git/allowed_signers" = {
          text = "jesse@jbhannah.net ${signing_key}";
        };

        ".config/nvim" = {
          source = ../../dotfiles/.config/nvim;
          recursive = true;
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

      programs._1password-shell-plugins = {
        enable = true;
        plugins = with pkgs; [
          gh
        ];
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

      programs.gemini-cli = {
        enable = true;

        settings = {
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
          gpg.ssh.program = lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
          init.defaultBranch = "trunk";
          log.showSignature = true;
          merge.conflictStyle = "zdiff3";
          pull.rebase = true;

          credential."https://gist.github.com".helper = lib.mkForce [
            ""
            "!op plugin run -- gh auth git-credential"
          ];
          credential."https://github.com".helper = lib.mkForce [
            ""
            "!op plugin run -- gh auth git-credential"
          ];
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
            program = lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
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
          lua5_1
          luarocks
          lynx
          markdownlint-cli2
          nil
          nixd
          nixfmt-rfc-style
          ruby
          shfmt
          stylua
          wget
        ];

        extraLuaPackages =
          ps: with ps; [
            tiktoken_core
          ];
      };

      programs.opencode = {
        enable = true;

        settings = {
          theme = "catppuccin";
        };
      };

      programs.ripgrep.enable = true;

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        matchBlocks."*" = {
          forwardAgent = true;
          identityAgent = ''"${_1password_ssh_agent_sock}"'';
        };
      };

      programs.starship = {
        enable = true;

        settings = {
          direnv = {
            disabled = false;
          };
          gcloud = {
            disabled = true;
          };
          nix_shell = {
            symbol = " ";
          };
          scala = {
            detect_folders = [ ];
          };
          shell = {
            disabled = false;
            fish_indicator = "🐟";
          };
        };
      };

      programs.tmux.enable = true;

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
