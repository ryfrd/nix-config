{
  services.openssh = {
    enable = true;
    ports = [ 97 ];
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  users.users.james.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPzFa1hmBsCrPL5HvJZhXVEaWiZIMi34oR6AOcKD35hQ james@countess" # laptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAIcy5Z+FMnDwmZYP0w7+qfKVHFXheAKd4PEmXKN3uqL james@desktop" # desktop
  ];

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
  };

  services.endlessh = {
    enable = true;
    openFirewall = true;
    ports = 22;
  };

}
