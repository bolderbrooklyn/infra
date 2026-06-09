{
  homebrew = {
    brews = [
      {
        name = "syncthing";
        restart_service = "changed";
      }
    ];

    casks = [
      "arc"
      "discord"
      "dolphin"
      "google-drive"
      "libndi"
      {
        name = "lm-studio";
        args.appdir = "/Applications";
      }
      "melonds"
      "mgba-app"
      "obs"
      "plex"
      "plexamp"
      "steam"
      {
        name = "tailscale-app";
        args.appdir = "/Applications";
      }
      "todoist-app"
    ];

    masApps = {
      "1Password for Safari" = 1569813296;
      "Compressor" = 424390742;
      "Final Cut Pro" = 424389933;
      "Logic Pro" = 634148309;
      "Motion" = 434290957;
      "Name Mangler 3" = 603637384;
      "Pixelmator Pro" = 1289583905;
      "Xcode" = 497799835;
      "Yoink" = 457622435;
    };
  };
}
