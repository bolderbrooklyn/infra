{ pkgs, ... }:
{
  home.shellAliases = {
    l = "ls -alh";
    cat = "${pkgs.bat.meta.mainProgram}";
  };

  imports = [
    ./gh.nix
    ./git.nix
  ];
}
