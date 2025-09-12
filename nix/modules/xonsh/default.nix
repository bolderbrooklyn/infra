{ pkgs, ... }:
let
  xonsh = pkgs.xonsh;
in
{
  environment.systemPackages = [ xonsh ];
  environment.shells = [ xonsh ];
}
