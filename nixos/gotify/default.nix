{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    gotify-cli
    smartmontools
  ];
}
