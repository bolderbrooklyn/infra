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
    "logi-options+"
    "notion"
    "notion-calendar"
    "notion-mail"
    {
      name = "slack";
      args.appdir = "/Applications";
    }
  ];
}
