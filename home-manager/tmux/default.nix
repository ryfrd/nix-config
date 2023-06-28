{ pkgs, ... }: {
  programs.tmux = {

    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    shell = "\${pkgs.fish}/bin/fish";


    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.weather;
        extraConfig = ''
          set-option -g status-right "#{weather}"
        '';
      }
    ];

    # extraConfig = ''
    #   set -g status-left '#(uptime)'
    # '';

  };
}
