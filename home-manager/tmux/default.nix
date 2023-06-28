{ pkgs, ... }: {
  programs.tmux = {

    enable = true;
    clock24 = true;


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
