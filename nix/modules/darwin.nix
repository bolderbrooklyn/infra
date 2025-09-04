{
  config,
  inputs,
  lib,
  ...
}:
let
  brew = "${config.homebrew.brewPrefix}/brew";

  shellInit = ''
    eval "$(${brew} shellenv)"
  '';
in
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  system.primaryUser = lib.mkDefault "brooklyn";

  nix.settings.trusted-users = [
    config.system.primaryUser
  ];

  users.users.${config.system.primaryUser} = {
    home = "/Users/${config.system.primaryUser}";
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = config.system.primaryUser;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "jbhannah/homebrew-pkpw" = inputs.homebrew-pkpw;
      "th-ch/homebrew-youtube-music" = inputs.homebrew-youtube-music;
    };
    mutableTaps = false;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;

    brews = [
      "colima"
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-credential-helper"
      "lima-additional-guestagents"
      "mas"
      "pkpw"
    ];

    caskArgs.appdir = "~/Applications";
    casks = [
      {
        name = "1password";
        args.appdir = "/Applications";
      }
      "arc"
      "alt-tab"
      "dash"
      "ghostty"
      "google-chrome"
      "httpie-desktop"
      {
        name = "lm-studio";
        args.appdir = "/Applications";
      }
      "pearcleaner"
      "stats"
      "the-unarchiver"
      "visual-studio-code"
      "warp"
      "youtube-music"
      "zed"
    ];

    masApps = {
      "1Password for Safari" = 1569813296;
      "Name Mangler 3" = 603637384;
      "Pixelmator Pro" = 1289583905;
      "Yoink" = 457622435;
    };

    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
  };

  programs.bash.interactiveShellInit = shellInit;

  programs.fish.enable = true;
  programs.fish.shellInit = ''
    ${brew} shellenv | source
  '';

  programs.zsh.shellInit = shellInit;

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
}
