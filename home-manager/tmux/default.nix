{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    shell = "\${pkgs.fish}/bin/fish";

    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.weather
    ];
  };
}
