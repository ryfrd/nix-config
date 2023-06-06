{ pkgs, config, ... }:
let
  bg = config.colorscheme.colors.base01;
  fg = config.colorscheme.colors.base06;
  ac = config.colorscheme.colors.base0F;
in
{
  home.packages = [ pkgs.wofi ];

  xdg.configFile."wofi/style.css" = {
    text = ''
            window {
                font-family: Agave Nerd Font 14;
	            background-color: #${bg};
                border-radius: 0px;
                border: 0px solid #${ac};
                margin:0px;
            }

            #input {
                margin: 5px;
                border: none;
                color: #${fg};
                background-color: #${bg};
            }

            #inner-box {
                margin: 5px;
                border: none;
                background-color: transparent;
            }

            #outer-box {
                margin: 5px;
                border: none;
                background-color: transparent;
            }

            #text {
                margin: 5px;
                border: none;
                color: #${fg};
            }

            #entry {
                border: none;
            }

            #entry:focus {
                border: none;
            }

            #entry:selected {
                color: #${ac};
                background-color: #${bg};
                border-radius: 0px;
                border: none;
            }
            '';
  };

  xdg.configFile."wofi/config" = {
    text = ''
            allow-images=true
            allow-markup=true
            filter_rate=100
            insensitive=true
            show=drun
            width=400
            height=300
            hide_scroll=true
            prompt=work hard play hard
        '';
  };
}

