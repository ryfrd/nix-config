{ lib, config, pkgs, ... }: {

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking.firewall.enable = true;
  services.tailscale.enable = true;

  users.users = {
    james = {
      isNormalUser = true;
      shell = pkgs.fish;
      initialPassword = "changethisyoupickle";
      extraGroups = [
        "wheel"
      ];
    };
  };
  programs.fish.enable = true;

}
