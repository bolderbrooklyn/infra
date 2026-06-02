{
  pkgs,
  ...
}:
let
  user = "kalmiya";
  homeDir = "/home/${user}";
in
{
  age.secrets.openclaw-env = {
    file = ./secrets/openclaw-env.age;
  };

  home = {
    username = user;
    homeDirectory = homeDir;

    packages = with pkgs; [
      _1password-cli
      fd
      ffmpeg-headless
      gcc
      gnumake
      opus
      python311
      sqlite-vec
      uv
      yq
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
    npm.enable = true;
    ripgrep.enable = true;
    tmux.enable = true;
  };

  xdg = {
    enable = true;
    localBinInPath = true;
  };
}
