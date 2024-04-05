{ pkgs, ... }: {

  imports = [
    ./common
    ./features/nvim/headless
  ];

}
