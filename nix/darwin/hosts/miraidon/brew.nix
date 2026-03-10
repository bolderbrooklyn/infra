{
  homebrew = {
    brews = [
      "imageoptim-cli"
      "libyaml"
      "sdl2"
      {
        name = "syncthing";
        restart_service = "changed";
      }
    ];

    casks = [
      "alfred"
      "arc"
      "balenaetcher"
      "chatgpt"
      "chrome-remote-desktop-host"
      "claude"
      "dash"
      "discord"
      "distroav"
      "dolphin"
      "firefox"
      "freetube"
      "google-chrome"
      "google-drive"
      "httpie-desktop"
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
      "microsoft-remote-desktop"
      "notion"
      "notion-calendar"
      "notion-mail"
      "obs"
      "obsidian"
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
      "todoist-app"
      "transmission"
      "virtualbox"
      "vivaldi"
      "vlc"
      "warp"
      "wave"
      "xquartz"
      "yaak"
      "zen"
    ];

    masApps = {
      "1Password for Safari" = 1569813296;
      "Compressor" = 424390742;
      "Final Cut Pro" = 424389933;
      "Logic Pro" = 634148309;
      "Motion" = 434290957;
      "Numbers" = 409203825;
      "Name Mangler 3" = 603637384;
      "Pixelmator Pro" = 1289583905;
      "Xcode" = 497799835;
      "Yoink" = 457622435;
    };
  };
}
