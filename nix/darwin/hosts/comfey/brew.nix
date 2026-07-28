{ inputs, ... }:
{
  nix-homebrew.taps = {
    "withgraphite/homebrew-tap" = inputs.homebrew-withgraphite;
  };

  homebrew = {
    brews = [
      "graphite"
      "openssl@3"
    ];

    casks = [
      "android-studio"
      "claude"
      "codex-app"
      "conductor"
      "dash"
      "figma"
      {
        name = "google-chrome";
        args.appdir = "/Applications";
      }
      "linear"
      {
        name = "lm-studio";
        args.appdir = "/Applications";
      }
      "logi-options+"
      "notion"
      "notion-calendar"
      "notion-mail"
      "obsidian"
      "openclaw"
      "opencode-desktop"
      "plexamp"
      {
        name = "slack";
        args.appdir = "/Applications";
      }
      {
        name = "tailscale-app";
        args.appdir = "/Applications";
      }
    ];
  };
}
