{ inputs, ... }:
{
  nix-homebrew.taps = {
    "withgraphite/homebrew-tap" = inputs.homebrew-withgraphite;
  };

  homebrew = {
    brews = [ "graphite" ];

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
