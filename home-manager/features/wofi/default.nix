{ config, ... }: 
let

  c = config.colorScheme.palette;

  wid = config.beautification.width;
  rad = config.beautification.radius; 

  font = config.fontProfiles.monospace.family;

in {

  programs.wofi = {
    enable = true;
    settings = {
      insensitive=true;
      show="run";
      width=400;
      height=300;
      hide_scroll=true;
      prompt="yer-->";
    };
    style = ''
      window {
        font-family: ${font};
      	background-color: #${c.base00};
        border-radius: ${rad}px;
        border: ${wid}px solid #${c.base03};
        margin:0px;
      }

      #input {
        margin: 5px;
        border: none;
        color: #${c.base05};
        background-color: #${c.base00};
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
        color: #${c.base05};
      }

      #entry {
        border: none;
      }

      #entry:focus {
        border: none;
      }

      #entry:selected {
        color: #${c.base03};
        background-color: #${c.base00};
        border-radius: 0px;
        border: none;
      }
    '';
  };
}
