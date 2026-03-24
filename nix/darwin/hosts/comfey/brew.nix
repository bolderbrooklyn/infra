{
  homebrew.casks = [
    "arc"
    "claude"
    "conductor"
    "dash"
    "figma"
    {
      name = "google-chrome";
      args.appdir = "/Applications";
    }
    "linear-linear"
    {
      name = "lm-studio";
      args.appdir = "/Applications";
    }
    "logi-options+"
    "notion"
    "notion-calendar"
    "notion-mail"
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
}
