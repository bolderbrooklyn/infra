{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.${config.common.username} =
    { config, ... }:
    let
      _1password_ssh_agent_sock = "${config.home.homeDirectory}/${
        if pkgs.stdenv.isDarwin then "Library/Group Containers/2BUA8C4S2C.com.1password/t" else ".1password"
      }/agent.sock";

      useCask = pkgs.stdenv.isDarwin;
    in
    {
      imports = [
        inputs._1password-shell-plugins.hmModules.default
      ];

      home.packages = lib.mkIf (!useCask) (with pkgs; [ _1password-gui ]);

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
