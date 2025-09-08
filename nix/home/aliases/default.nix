{ pkgs, ... }:
{
  home.shellAliases = {
    l = "ls -alh";
    cat = "${pkgs.bat}/bin/bat";
  };
}
