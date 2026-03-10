{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
in
{
  programs._1password.enable = !pkgs.stdenv.isDarwin;

  programs._1password-gui = {
    enable = !pkgs.stdenv.isDarwin;
  }
  // lib.mkIf (!pkgs.stdenv.isDarwin) (
    lib.optionalAttrs (lib.hasAttr "polkitPolicyOwners" config.programs._1password-gui) {
      polkitPolicyOwners = [ username ];
    }
  );

  home-manager.users.${username} =
    { config, ... }:
    let
      _1password_ssh_agent_sock = "${config.home.homeDirectory}/${
        if pkgs.stdenv.isDarwin then "Library/Group Containers/2BUA8C4S2C.com.1password/t" else ".1password"
      }/agent.sock";
    in
    {
      imports = [
        inputs._1password-shell-plugins.hmModules.default
      ];

      home.sessionVariables = {
        SSH_AUTH_SOCK = _1password_ssh_agent_sock;
      };

      programs = {
        _1password-shell-plugins = {
          enable = true;
          plugins = lib.mkIf config.programs.gh.enable [
            pkgs.gh
          ];
        };

        git.settings = lib.mkIf config.programs.git.enable {
          gpg.ssh.program = lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };

        jujutsu.settings = lib.mkIf config.programs.jujutsu.enable {
          signing.program = lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };

        ssh = {
          matchBlocks."*" = {
            forwardAgent = true;
            identityAgent = ''"${_1password_ssh_agent_sock}"'';
          };
        };
      };
    };

  homebrew = lib.optionalAttrs pkgs.stdenv.isDarwin {
    casks = [
      {
        name = "1password";
        args.appdir = "/Applications";
      }
    ];
  };
}
