{
  homebrew.casks = [
    "arc"
    "claude"
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
