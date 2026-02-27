{
  homebrew = {
    casks = [
      "arc"
      "chatgpt"
      "chatgpt-atlas"
      "codex"
      "codex-app"
      "cursor"
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
