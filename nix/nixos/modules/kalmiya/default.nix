{ ... }:
let
  user = "kalmiya";
  home = "/home/${user}";
in
{
  users.users.${user} = {
    inherit home;

    isNormalUser = true;
    description = "Kalmiya service user";
    group = "users";
    linger = true;

    openssh.authorizedKeys.keys = [ ];
  };

  home-manager.users.${user} = import ../../../kalmiya-home/home.nix;
}
