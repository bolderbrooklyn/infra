{
  config,
  inputs,
  lib,
  options,
  pkgs,
  ...
}:
let
  username = config.common.username;

  useCask = pkgs.stdenv.isDarwin;
in
{
  programs._1password.enable = !useCask;

  programs._1password-gui = {
    enable = !useCask;
  }
  // lib.mkIf (!useCask) (
    lib.optionalAttrs (builtins.hasAttr "polkitPolicyOwners" config.programs._1password-gui) {
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

      programs._1password-shell-plugins = {
        enable = true;
        plugins = lib.mkIf config.programs.gh.enable [
          pkgs.gh
        ];
      };

      programs.git.extraConfig = lib.mkIf config.programs.git.enable {
        gpg.ssh.program = lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";

        credential."https://gist.github.com".helper = lib.mkForce [
          ""
          "!op plugin run -- gh auth git-credential"
        ];
        credential."https://github.com".helper = lib.mkForce [
          ""
          "!op plugin run -- gh auth git-credential"
        ];
      };

      programs.jujutsu.settings = lib.mkIf config.programs.jujutsu.enable {
        signing.program = lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };

      programs.ssh = {
        matchBlocks."*" = {
          forwardAgent = true;
          identityAgent = ''"${_1password_ssh_agent_sock}"'';
        };
      };
    };
}
// lib.mkIf useCask (
  lib.optionalAttrs (builtins.hasAttr "homebrew" options) {
    homebrew.casks = [
      {
        name = "1password";
        args.appdir = "/Applications";
      }
    ];
  }
)
