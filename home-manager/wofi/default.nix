{ pkgs, config, ... }: 
let

  bg = config.colorscheme.colors.base00;
  fg = config.colorscheme.colors.base07;
  ac = config.colorscheme.colors.base0E;

  wid = config.borderValues.width;
  rad = config.borderValues.radius;

  font = config.fontProfiles.monospace.family;

in
{
  programs.wofi = {
    enable = true;
    settings = {
      allow-images=true;
      allow-markup=true;
      filter_rate=100;
      insensitive=true;
      show="drun";
      width=400;
      height=300;
      hide_scroll=true;
      prompt="work hard play hard";
    };
    style = ''
      window {
        font-family: ${font};
      	background-color: #${bg};
        border-radius: ${rad}px;
        border: ${wid}px solid #${ac};
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
}
