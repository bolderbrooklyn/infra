{
  config,
  lib,
  pkgs,
  ...
}:
let
  user = "kalmiya";
  homeDir = "/home/${user}";
  npmPrefix = "${homeDir}/.npm-global";
in
{
  age.secrets.openclaw-env = {
    file = ./secrets/openclaw-env.age;
  };

  home = {
    username = user;
    homeDirectory = homeDir;

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

  home.activation.createOpenclawEnv = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/.openclaw"
    ln -sf "${config.age.secrets.openclaw-env.path}" "${config.home.homeDirectory}/.openclaw/.env"
  '';

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
}
