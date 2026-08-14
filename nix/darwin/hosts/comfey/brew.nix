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
      "chatgpt"
      "claude"
      "conductor"
      "dash"
      "figma"
      {
        name = "google-chrome";
        args.appdir = "/Applications";
      }
      "helium-browser"
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
      "t3-code"
      {
        name = "tailscale-app";
        args.appdir = "/Applications";
      }
    ];
  };
}
