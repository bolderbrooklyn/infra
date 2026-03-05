{
  homebrew = {
    casks = [
      "arc"
      "chatgpt"
      "chatgpt-atlas"
      "claude"
      "codex-app"
      "dash"
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
  };
}
