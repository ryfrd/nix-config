{ lib, config, pkgs, ... }: {

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      trusted-users = [ "james" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
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
