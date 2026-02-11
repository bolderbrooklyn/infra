{
  homebrew = {
    brews = [
      "imageoptim-cli"
      "sdl2"
      {
        name = "syncthing";
        restart_service = "changed";
      }
    ];

    casks = [
      "alfred"
      "balenaetcher"
      "calibre"
      "chatgpt"
      "chrome-remote-desktop-host"
      "claude"
      "discord"
      "distroav"
      "dolphin"
      "firefox"
      "freetube"
      "google-drive"
      "iina"
      "imageoptim"
      "krita"
      "libndi"
      {
        name = "lm-studio";
        args.appdir = "/Applications";
      }
      "melonds"
      "mgba-app"
      "microsoft-edge"
      "notion"
      "notion-calendar"
      "notion-mail"
      "obs"
      "opera"
      "plex"
      "plexamp"
      "pokemon-tcg-live"
      "prismlauncher"
      "slack"
      "steam"
      {
        name = "tailscale-app";
        args.appdir = "/Applications";
      }
      "telegram"
      "transmission"
      "virtualbox"
      "vivaldi"
      "wave"
      "xquartz"
      "yaak"
      "zen"
    ];

    masApps = {
      "Compressor" = 424390742;
      "Final Cut Pro" = 424389933;
      "Logic Pro" = 634148309;
      "Motion" = 434290957;
      "Numbers" = 409203825;
    };
  };
}
