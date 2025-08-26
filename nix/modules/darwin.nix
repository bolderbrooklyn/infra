{
  pkgs,
  config,
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
  nix.enable = false;

  system.primaryUser = lib.mkDefault "brooklyn";

  users.users.${config.system.primaryUser} = {
    home = "/Users/${config.system.primaryUser}";
  };

  environment.systemPackages = with pkgs; [
    fish
    powershell
  ];

  environment.shells = with pkgs; [
    fish
    powershell
  ];

  homebrew = {
    enable = true;

    taps = [
      "domt4/autoupdate"
      "jbhannah/pkpw"
      "sst/tap"
    ];

    brews = [
      {
        name = "colima";
        restart_service = "changed";
      }
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-credential-helper"
      "lima-additional-guestagents"
      "mas"

      "jbhannah/pkpw/pkpw"
      "sst/tap/opencode"
    ];

    caskArgs.appdir = "~/Applications";
    casks = [
      {
        name = "1password";
        args.appdir = "/Applications";
      }
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
    ];

    masApps = {
      "Name Mangler 3" = 603637384;
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

  system.activationScripts.postActivation = {
    enable = true;
    text = ''
      sudo -u ${config.system.primaryUser} -i ${brew} autoupdate start --upgrade --immediate --cleanup --sudo || true
    '';
  };
}
