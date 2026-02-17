{ config, lib, ... }:
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
    ./aliases/git.nix
  ];

  config = {
    home-manager.users.${config.common.username} =
      { config, ... }:
      {
        programs = {
          delta = {
            enable = true;

            options = {
              line-numbers = true;
              navigate = true;
              side-by-side = true;
            };
          };

          git = {
            enable = true;
            lfs.enable = true;

            signing = {
              inherit (cfg.signingKey) key;
              format = cfg.signingKey.type;
              signByDefault = true;
              signer = "ssh-keygen";
            };

            ignores = [
              ".DS_Store"
            ];

            settings = {
              user.email = cfg.user.email;
              user.name = cfg.user.name;
              fetch.prune = true;
              gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
              init.defaultBranch = "trunk";
              log.showSignature = true;
              merge.conflictStyle = "zdiff3";
              pull.rebase = true;
              push.autoSetupRemote = true;
            };
          };

          gh = {
            enable = true;
            gitCredentialHelper.enable = true;
          };

          lazygit = {
            enable = true;

            settings = {
              git.mainBranches = [
                "trunk"
                "main"
                "master"
              ];

              gui.nerdFontsVersion = "3";
            };
          };
        };

        # TODO: move these to an attrset
        xdg.configFile."git/allowed_signers".text = ''
          jesse@jbhannah.net ${cfg.signingKey.key}
        '';
      };
  };
}
