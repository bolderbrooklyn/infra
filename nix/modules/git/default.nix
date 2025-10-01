{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.git;

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
  options.programs.git = {
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

  imports = [
    ./aliases/gh.nix
    ./aliases/git.nix
  ];

  config = {
    home-manager.users.${config.common.username} =
      { config, ... }:
      {
        home.packages = with pkgs; [
          lazyjj
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
            push.autoSetupRemote = true;
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
            user = {
              email = cfg.user.email;
              name = cfg.user.name;
            };

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

        # TODO: move these to an attrset
        xdg.configFile."git/allowed_signers".text = ''
          jesse@jbhannah.net ${cfg.signingKey.key}
          bhannah@tvscientific.com ${cfg.signingKey.key}
        '';
      };
  };
}
