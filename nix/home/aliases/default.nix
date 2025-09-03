{ pkgs, ... }:
{
  home.shellAliases = {
    l = "ls -alh";
    cat = "${pkgs.bat}/bin/bat";
  };

  imports = [
    ./gh.nix
    ./git.nix
  ];
}
