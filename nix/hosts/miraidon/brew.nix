{ inputs, ... }:
{
  nix-homebrew.taps = {
    "th-ch/homebrew-youtube-music" = inputs.homebrew-youtube-music;
  };

  homebrew = {
    brews = [
      {
        name = "syncthing";
        restart_service = "changed";
      }
      "imageoptim-cli"
    ];

    casks = [
      "alfred"
      "balenaetcher"
      "brave-browser"
      "calibre"
      "chatgpt"
      "chrome-remote-desktop-host"
      "claude"
      "discord"
      "distroav"
      "firefox"
      "freetube"
      "gcloud-cli"
      "google-drive"
      "imageoptim"
      "krita"
      "libndi"
      "melonds"
      "mgba-app"
      "microsoft-edge"
      "nordvpn"
      "notion"
      "notion-calendar"
      "notion-mail"
      "obs"
      "opera"
      "plex"
      "plexamp"
      "pokemon-tcg-live"
      "prismlauncher"
      "steam"
      {
        name = "tailscale-app";
        args.appdir = "/Applications";
      }
      "telegram"
      "virtualbox"
      "vivaldi"
      "xquartz"
      "youtube-music"
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
