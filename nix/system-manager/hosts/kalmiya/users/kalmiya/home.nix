{ pkgs, ... }:
{
  home-manager.users.kalmiya.home = {
    packages = with pkgs; [
      git
      nodejs
      python3
      uv
    ];

    stateVersion = "26.05";
  };
}
