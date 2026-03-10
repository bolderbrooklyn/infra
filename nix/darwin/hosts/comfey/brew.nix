{
  homebrew = {
    brews = [
      ### START krunkit dependencies
      "dtc"
      "krunkit"
      "libepoxy"
      "molten-vk"
      "slp/krunkit/libkrun-efi"
      "slp/krunkit/virglrenderer"
      ### END krunkit dependencies
    ];

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
