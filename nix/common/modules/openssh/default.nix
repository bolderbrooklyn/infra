{
  services.openssh = {
    extraConfig = ''
      PasswordAuthentication no
      PermitRootLogin no
    '';
  };
}
