let
  user = "kalmiya";
  home = "/home/${user}";
  npmPrefix = "${home}/.npm-global";
in
{
  users.users.${user} = {
    inherit home;

    isNormalUser = true;
    description = "Kalmiya service user";
    group = "users";
    linger = true;

    openssh.authorizedKeys.keys = [ ];
  };

  home-manager.users.${user} =
    { pkgs, ... }:
    {
      home = {
        sessionPath = [
          "${npmPrefix}/bin"
        ];

        packages = with pkgs; [
          _1password-cli
          fd
          ffmpeg-headless
          mcporter
          sqlite-vec
        ];

        stateVersion = "26.05";
        enableNixpkgsReleaseCheck = false;
      };

      programs = {
        home-manager.enable = true;

        bash.enable = true;
        chromium.enable = true;
        git.enable = true;
        jq.enable = true;
        neovim.enable = true;
        ripgrep.enable = true;
        tmux.enable = true;

        npm = {
          enable = true;

          settings = {
            prefix = npmPrefix;
          };
        };
      };

      xdg.enable = true;
    };
}
