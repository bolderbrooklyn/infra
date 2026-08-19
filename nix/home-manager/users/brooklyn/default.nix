{
  imports = [
    ../..
  ];

  brooklyn = {
    programs.git.enable = true;
    programs.pi-coding-agent.enable = true;
  };
}
