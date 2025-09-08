{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.git;

  signingKey = {
    type = "ssh";
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAnSncawa7Y3U7/ZUkqnXLrAgJ5mxNLLKOgM20+dsV+";
  };

  user = {
    name = "jesse brooklyn hannah";
    email = "jesse@jbhannah.net";
  };
in
{
  options.git = {
    signingKey = {
      type = lib.mkOption {
        type = lib.types.enum [
          "ssh"
          "gpg"
        ];
        default = signingKey.type;
      };

      key = lib.mkOption {
        type = lib.types.str;
        default = signingKey.key;
      };
    };

    user = {
      name = lib.mkOption {
        type = lib.types.str;
        default = user.name;
      };

      email = lib.mkOption {
        type = lib.types.str;
        default = user.email;
      };
    };
  };

  config = {
    home-manager.users.${config.common.username} =
      { config, ... }:
      {
        imports = [
          ./aliases/gh.nix
          ./aliases/git.nix
        ];

        programs.git = {
          enable = true;
          lfs.enable = true;

          userEmail = cfg.user.email;
          userName = cfg.user.name;

          signing = {
            key = cfg.signingKey.key;
            format = cfg.signingKey.type;
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

          ignores = [
            ".DS_Store"
          ];

          extraConfig = {
            fetch.prune = true;
            gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
            init.defaultBranch = "trunk";
            log.showSignature = true;
            merge.conflictStyle = "zdiff3";
            pull.rebase = true;
          };
        };

        programs.gh = {
          enable = true;
          gitCredentialHelper.enable = true;

          extensions = with pkgs; [
            gh-copilot
          ];
        };

        programs.jujutsu = {
          enable = true;

          settings = {
            user.email = cfg.user.email;
            user.name = cfg.user.name;

            signing = {
              behavior = "own";
              backend = cfg.signingKey.type;
              key = cfg.signingKey.key;
              allowed-signers = "${config.xdg.configHome}/git/allowed_signers";
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

        xdg.configFile."git/allowed_signers" = {
          text = ''
            jesse@jbhannah.net ${cfg.signingKey.key}
            bhannah@tvscientific.com ${cfg.signingKey.key}
          '';
        };
      };
  };
}
