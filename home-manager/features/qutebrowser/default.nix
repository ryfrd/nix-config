{ config, pkgs, ... }:
let

  c = config.colorScheme.palette;
  font = config.beautification.fontName;

in {

  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = true;
    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      g = "https://google.com/search?q={}";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
      np = "https://search.nixos.org/packages?query={}";
      no = "https://search.nixos.org/options?query={}";
      m = "https://www.openstreetmap.org/search?query={}";
      rym = "https://rateyourmusic.com/search?searchterm={}";
      lb = "https://letterboxd.com/search/{}";
    };
    settings = {
      url.start_pages = "file:///home/james/.ciao.html";
      fonts = {
        default_family = "${font}";
        default_size = "13pt";
      };
      colors = {
        webpage = {
          preferred_color_scheme = config.colorscheme.variant;
          bg = "#ffffff";
        };
        completion = {
          fg = "#${c.base05}";
          match.fg = "#${c.base09}";
          even.bg = "#${c.base00}";
          odd.bg = "#${c.base00}";
          scrollbar = {
            bg = "#${c.base00}";
            fg = "#${c.base05}";
          };
          category = {
            bg = "#${c.base00}";
            fg = "#${c.base0D}";
            border = {
              bottom = "#${c.base00}";
              top = "#${c.base00}";
            };
          };
          item.selected = {
            bg = "#${c.base02}";
            fg = "#${c.base05}";
            match.fg = "#${c.base05}";
            border = {
              bottom = "#${c.base02}";
              top = "#${c.base02}";
            };
          };
        };
        contextmenu = {
          disabled = {
            bg = "#${c.base01}";
            fg = "#${c.base04}";
          };
          menu = {
            bg = "#${c.base00}";
            fg = "#${c.base05}";
          };
          selected = {
            bg = "#${c.base02}";
            fg = "#${c.base05}";
          };
        };
        downloads = {
          bar.bg = "#${c.base00}";
          error.fg = "#${c.base08}";
          start = {
            bg = "#${c.base0D}";
            fg = "#${c.base00}";
          };
          stop = {
            bg = "#${c.base0C}";
            fg = "#${c.base00}";
          };
        };
        hints = {
          bg = "#${c.base0A}";
          fg = "#${c.base00}";
          match.fg = "#${c.base05}";
        };
        keyhint = {
          bg = "#${c.base00}";
          fg = "#${c.base05}";
          suffix.fg = "#${c.base05}";
        };
        messages = {
          error.bg = "#${c.base08}";
          error.border = "#${c.base08}";
          error.fg = "#${c.base00}";
          info.bg = "#${c.base00}";
          info.border = "#${c.base00}";
          info.fg = "#${c.base05}";
          warning.bg = "#${c.base0E}";
          warning.border = "#${c.base0E}";
          warning.fg = "#${c.base00}";
        };
        prompts = {
          bg = "#${c.base00}";
          fg = "#${c.base05}";
          border = "#${c.base00}";
          selected.bg = "#${c.base02}";
        };
        statusbar = {
          caret.bg = "#${c.base00}";
          caret.fg = "#${c.base0D}";
          caret.selection.bg = "#${c.base00}";
          caret.selection.fg = "#${c.base0D}";
          command.bg = "#${c.base01}";
          command.fg = "#${c.base04}";
          command.private.bg = "#${c.base01}";
          command.private.fg = "#${c.base0E}";
          insert.bg = "#${c.base00}";
          insert.fg = "#${c.base0C}";
          normal.bg = "#${c.base00}";
          normal.fg = "#${c.base05}";
          passthrough.bg = "#${c.base00}";
          passthrough.fg = "#${c.base0A}";
          private.bg = "#${c.base00}";
          private.fg = "#${c.base0E}";
          progress.bg = "#${c.base0D}";
          url.error.fg = "#${c.base08}";
          url.fg = "#${c.base05}";
          url.hover.fg = "#${c.base0A}";
          url.success.http.fg = "#${c.base0B}";
          url.success.https.fg = "#${c.base0B}";
          url.warn.fg = "#${c.base0E}";
        };
        tabs = {
          bar.bg = "#${c.base00}";
          even.bg = "#${c.base00}";
          even.fg = "#${c.base05}";
          indicator.error = "#${c.base08}";
          indicator.start = "#${c.base0D}";
          indicator.stop = "#${c.base0C}";
          odd.bg = "#${c.base00}";
          odd.fg = "#${c.base05}";
          pinned.even.bg = "#${c.base0B}";
          pinned.even.fg = "#${c.base00}";
          pinned.odd.bg = "#${c.base0B}";
          pinned.odd.fg = "#${c.base00}";
          pinned.selected.even.bg = "#${c.base02}";
          pinned.selected.even.fg = "#${c.base05}";
          pinned.selected.odd.bg = "#${c.base02}";
          pinned.selected.odd.fg = "#${c.base05}";
          selected.even.bg = "#${c.base02}";
          selected.even.fg = "#${c.base05}";
          selected.odd.bg = "#${c.base02}";
          selected.odd.fg = "#${c.base05}";
        };
      };
    };
  };

  home.file.".ciao.html".text = ''
    <html>
      <head>
        <title></title>
        <style>
          body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* 100% of the viewport height */
            margin: 0; /* Remove default margin */
            background: #${c.base00};
            color: #${c.base05};
            font-family: ${font};
          }
          .center-text {
            text-align: center;
          }
        </style>
      </head>
      <body>
        <div class="center-text">
          guten morgen :)
        </div>
      </body>
    </html>
  '';
}
