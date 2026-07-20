{
  homebrew = {
    brews = [
      {
        name = "syncthing";
        restart_service = "changed";
      }
    ];

    casks = [
      "discord"
      "dolphin"
      "google-drive"
      "libndi"
      {
        name = "lm-studio";
        args.appdir = "/Applications";
      }
      "logi-options+"
      "melonds"
      "mgba-app"
      "obs"
      "obsidian"
      "openclaw"
      "plex"
      "plexamp"
      "pokemon-tcg-live"
      "prismlauncher"
      "steam"
      {
        name = "tailscale-app";
        args.appdir = "/Applications";
      }
      "telegram-desktop"
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
