{
  config,
  pkgs,
  agenix,
  ...
}:
let
  user = "kalmiya";
  homeDir = "/home/${user}";
  npmPrefix = "${homeDir}/.npm-global";
in
{
  imports = [
    agenix.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  age.identityPaths = [
    "${config.home.homeDirectory}/.ssh/id_ed25519"
  ];

  age.secrets."op-service-account-token" = {
    file = ./secrets/op-service-account-token.age;
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

  home.file.".openclaw/.env" = {
    source = ''
      OP_SERVICE_ACCOUNT_TOKEN=$(cat ${config.age.secrets.op-service-account-token.path})
    '';
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
}
