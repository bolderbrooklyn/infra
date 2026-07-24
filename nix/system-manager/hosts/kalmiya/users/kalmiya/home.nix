{ pkgs, ... }:
{
  home-manager.users.kalmiya.home = {
    packages = with pkgs; [
      _1password-cli
      git
      nodejs
      python3
      uv
    ];

    stateVersion = "26.05";
  };
}
