{
  config,
  inputs,
  pkgs,
  ...
}:
let
  username = config.common.username;

  shells = with pkgs; [
    nushell
    xonsh
  ];
in
{
  imports = [
    ./common.nix
    inputs.home-manager.darwinModules.home-manager
    ../home/darwin.nix
    ../modules/brew
    ../modules/gui
    ../modules/powershell
  ];

  environment.systemPackages = shells;
  environment.shells = shells;

  system.stateVersion = 6;

  system.primaryUser = username;

  nix.settings.trusted-users = [
    username
  ];

  nix-homebrew.taps = {
    "jbhannah/homebrew-pkpw" = inputs.homebrew-pkpw;
    "th-ch/homebrew-youtube-music" = inputs.homebrew-youtube-music;
  };

  homebrew = {
    brews = [
      "colima"
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-credential-helper"
      "gemini-cli"
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
      "alacritty"
      "alt-tab"
      "arc"
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

  programs.powershell.enable = true;

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
}
