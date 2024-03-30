{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
  };
  home.packages = with pkgs.emacsPackages; [
    use-package
    evil
    doom-modeline
    nerd-icons
  ];
}
