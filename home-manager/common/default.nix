{ lib, config, pkgs, nix-colors, ... }:
let
  inherit (nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;

  c = config.colorScheme.palette;

  wid = "1";
  rad = "2"; 
  gap = "10";

  font = "Agave Nerd Font";

in
rec {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    # gui
    bitwarden-desktop
    gimp
    jellyfin-media-player

    # cli
    eza
    ripgrep
    fd
    curl
    wget
    tree
    dua
    htop
    sxiv
    zathura
    mpv
    cava
    pulsemixer
    pfetch

    # hyprland config deps
    playerctl
    pamixer
    swaybg

    # nvim deps
    wl-clipboard
    gcc
    nodePackages.pyright
    nodePackages.bash-language-server
    luaPackages.lua-lsp
    gopls
    fd
    fortune

    fishPlugins.z
    fishPlugins.autopair
    fishPlugins.done
    fishPlugins.sponge

  ];

  home = {
    username = "james";
    homeDirectory = "/home/james";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
    };
  };
  programs.fish = {
    enable = true;
    shellInit = "
      set fish_greeting ''
      pfetch
      starship init fish | source
    ";
    shellAliases = {
      "ls" = "eza";
      "grep" = "rg";
      "i" = "curl -s https://ipinfo.io";
      "update" = "cd ~/sync/nix/multihost && nix flake update && sudo nixos-rebuild switch --flake .#$(hostname)";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
    };
    functions = {
      twitch = "${pkgs.streamlink}/bin/streamlink https://twitch.tv/$argv[1] best -p mpv";
      port = "sudo netstat -tulpn | grep $argv[1]";
      g = "git add * && git commit -m '$argv[1]' && git push";
    };
  };
  home.sessionVariables = {
    PF_INFO = "os kernel uptime memory shell editor de palette";
  };

  programs.git = {
    enable = true;
    userName = "ryfrd";
    userEmail = "jdysmcl@tutanota.com";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = false;

    settings = {

      general = {
        gaps_in = "${gap}";
        gaps_out = "${gap}";
        border_size = "${wid}";
        "col.active_border" = "rgb(${c.base09})";
        "col.inactive_border" = "rgb(${c.base00})";
      };

      dwindle.default_split_ratio = 1.08;

      animations = {
        enabled = 0;
      };

      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        fullscreen_opacity = 1.0;
        rounding = "${rad}";
        blur.enabled = true;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgb(${c.base09})";
      };

      misc = {
        enable_swallow = true;
        swallow_regex = "'^(Kitty|Alacritty)$'";
      };

      gestures = {
        workspace_swipe = false;
      };

      exec-once = [
        "${pkgs.swaybg}/bin/swaybg -i ~/.background -m fill"
      ];

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      bind = let 

        terminal = config.home.sessionVariables.TERMINAL;
        editor = config.home.sessionVariables.EDITOR;
        launcher = "${config.programs.wofi.package}/bin/wofi";

        in [

          # quit
          "SUPERSHIFT,q,exit"

          # launch items
          "SUPER,Return,exec,${terminal}"
          "SUPER,e,exec,${terminal} -e ${editor}"
          "SUPER,d,exec,${launcher}"

          # media
          "SUPERSHIFT,right,exec,playerctl next"
          "SUPERSHIFT,left,exec,playerctl previous"
          "SUPERSHIFT,up,exec,playerctl play-pause"
          "SUPERSHIFT,down,exec,playerctl stop"
          
          # volume
          "SUPER,up,exec,pamixer -i 5 && dunstify volume $(pamixer --get-volume)"
          "SUPER,down,exec,pamixer -d 5 && dunstify volume $(pamixer --get-volume)"

          # brightness
          "SUPER,right,exec,light -A 5 && dunstify brightness $(light)"
          "SUPER,left,exec,light -U 5 && dunstify brightness $(light)"

          # info
          "SUPER,u,exec,dunstify battery $(cat /sys/class/power_supply/BAT0/capacity)"
          "SUPER,i,exec,dunstify backlight $(light)"
          "SUPER,o,exec,dunstify volume $(pamixer --get-volume)"
          "SUPER,p,exec,dunstify time $(date +'%H:%M')"

          # windows
          "SUPER,q,killactive"
          "SUPER,f,fullscreen"
          "SUPERSHIFT,f,togglefloating"
          "SUPER,space,cyclenext"
          "SUPERSHIFT,space,swapnext"

          "SUPER,h,movefocus,l"
          "SUPER,l,movefocus,r"
          "SUPER,k,movefocus,u"
          "SUPER,j,movefocus,d"

          "SUPERSHIFT,h,swapwindow,l"
          "SUPERSHIFT,l,swapwindow,r"
          "SUPERSHIFT,k,swapwindow,u"
          "SUPERSHIFT,j,swapwindow,d"

          # workspaces
          "SUPER,1,workspace,1"
          "SUPER,2,workspace,2"
          "SUPER,3,workspace,3"
          "SUPER,4,workspace,4"
          "SUPER,5,workspace,5"
          "SUPER,6,workspace,6"
          "SUPER,7,workspace,7"
          "SUPER,8,workspace,8"
          "SUPER,9,workspace,9"

          "SUPERSHIFT,1,movetoworkspace,1"
          "SUPERSHIFT,2,movetoworkspace,2"
          "SUPERSHIFT,3,movetoworkspace,3"
          "SUPERSHIFT,4,movetoworkspace,4"
          "SUPERSHIFT,5,movetoworkspace,5"
          "SUPERSHIFT,6,movetoworkspace,6"
          "SUPERSHIFT,7,movetoworkspace,7"
          "SUPERSHIFT,8,movetoworkspace,8"
          "SUPERSHIFT,9,movetoworkspace,9"

          "SUPER,mouse_down,workspace,e+1"
          "SUPER,mouse_up,workspace,e-1"

        ];

    };
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        offset = "${gap}x${gap}";
        font = "${font} 12";
        frame_width = "${wid}";
        frame_color = "#${c.base09}";
        corner_radius = "${rad}";
        background = "#${c.base00}";
        foreground = "#${c.base05}";
      };
    };
  };

  # redshift
  services.redshift = {
    enable = true;
    latitude = 55.9;
    longitude = 4.3;
  };

  # gtk
  gtk = {
    enable = true;
    font = {
      name = "${font}";
      size = 12;
    };
    theme = {
      name = "${config.colorscheme.slug}";
      package = gtkThemeFromScheme { scheme = config.colorscheme; };
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "${gtk.theme.name}";
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  # terminal
  home.sessionVariables.TERMINAL = "kitty";
  programs.kitty = {
    enable = true;
    font = {
      name = "${font}";
      size = 14;
    };
    settings = {
      shell_integration = "no-rc";

      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      enable_audio_bell = "no";
      confirm_os_window_close = 0;

      foreground = "#${c.base05}";
      background = "#${c.base00}";
      selection_background = "#${c.base05}";
      selection_foreground = "#${c.base00}";
      url_color = "#${c.base04}";
      cursor = "#${c.base05}";
      active_border_color = "#${c.base03}";
      inactive_border_color = "#${c.base01}";
      active_tab_background = "#${c.base00}";
      active_tab_foreground = "#${c.base05}";
      inactive_tab_background = "#${c.base01}";
      inactive_tab_foreground = "#${c.base04}";
      tab_bar_background = "#${c.base01}";
      color0 = "#${c.base00}";
      color1 = "#${c.base08}";
      color2 = "#${c.base0B}";
      color3 = "#${c.base0A}";
      color4 = "#${c.base0D}";
      color5 = "#${c.base0E}";
      color6 = "#${c.base0C}";
      color7 = "#${c.base05}";
      color8 = "#${c.base03}";
      color9 = "#${c.base08}";
      color10 = "#${c.base0B}";
      color11 = "#${c.base0A}";
      color12 = "#${c.base0D}";
      color13 = "#${c.base0E}";
      color14 = "#${c.base0C}";
      color15 = "#${c.base07}";
      color16 = "#${c.base09}";
      color17 = "#${c.base0F}";
      color18 = "#${c.base01}";
      color19 = "#${c.base02}";
      color20 = "#${c.base04}";
      color21 = "#${c.base06}";
    };
  };

  # launcher
  programs.wofi = {
    enable = true;
    settings = {
      insensitive=true;
      show="drun";
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
        border: ${wid}px solid #${c.base09};
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
        color: #${c.base09};
        background-color: #${c.base00};
        border-radius: 0px;
        border: none;
      }
    '';
  };

  # web browser
  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = true;
    searchEngines = {
      DEFAULT = "https://srx.dymc.win/search?q={}";
      #DEFAULT = "https://duckduckgo.com/?q={}";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
      np = "https://search.nixos.org/packages?query={}";
      no = "https://search.nixos.org/options?query={}";
      m = "https://www.openstreetmap.org/search?query={}";
      rym = "https://rateyourmusic.com/search?searchterm={}";
      lb = "https://letterboxd.com/search/{}";
    };
    settings = {
      url.start_pages = "https://srx.dymc.win";
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
          url.hover.fg = "#${c.base09}";
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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraLuaConfig = ''
      -- backup file
      vim.cmd('set nobackup')
      -- clipboard admin
      vim.cmd('set clipboard=unnamedplus')

      -- disable swapfile
      vim.cmd('set noswapfile')

      -- tab admin
      vim.cmd('set tabstop=2')
      vim.cmd('set softtabstop=2')
      vim.cmd('set shiftwidth=2')
      vim.cmd('set expandtab')

      -- line numbers
      vim.cmd('set number relativenumber')

      -- termguicolors
      vim.cmd('set termguicolors')

      -- keys
      local keymap = vim.keymap

      -- map leader to space
      keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
      vim.g.mapleader = " "

      -- telescope
      keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
      keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<cr>', {})
      keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', {})
      keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {})
      keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>', {})
      keymap.set('n', '<leader>pp', '<cmd>Telescope project<cr>', {})

      -- buffers
      keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', {})
      keymap.set('n', '<leader>bh', '<cmd>bprevious<cr>', {})
      keymap.set('n', '<leader>bl', '<cmd>bdelete<cr>', {})

      -- splits
      keymap.set('n', '<leader>-', '<cmd>split<cr>', {})
      keymap.set('n', '<leader>|', '<cmd>vsplit<cr>', {})

      -- move focus
      keymap.set('n', '<leader>h', '<C-W>h', {})
      keymap.set('n', '<leader>j', '<C-W>j', {})
      keymap.set('n', '<leader>k', '<C-W>k', {})
      keymap.set('n', '<leader>l', '<C-W>l', {})

      -- zen 
      keymap.set('n', '<leader>zz', '<cmd>ZenMode<cr>', {})
    '';
    plugins = with pkgs.vimPlugins; [
      zen-mode-nvim
      nvim-web-devicons

      {
        plugin = mini-nvim;
        config = ''
          lua << END
          require('mini.align').setup()
          require('mini.base16').setup({
            palette = {
              base00 = '#${c.base00}',
              base01 = '#${c.base01}',
              base02 = '#${c.base02}',
              base03 = '#${c.base03}',
              base04 = '#${c.base04}',
              base05 = '#${c.base05}',
              base06 = '#${c.base06}',
              base07 = '#${c.base07}',
              base08 = '#${c.base08}',
              base09 = '#${c.base09}',
              base0A = '#${c.base0A}',
              base0B = '#${c.base0B}',
              base0C = '#${c.base0C}',
              base0D = '#${c.base0D}',
              base0E = '#${c.base0E}',
              base0F = '#${c.base0F}',
            },
          })
          require('mini.comment').setup()
          require('mini.indentscope').setup()
          require('mini.pairs').setup()

          local handle = io.popen('fortune -s')
          local meat = handle:read("*a")
          handle:close()
          require('mini.starter').setup({
            footer = meat,
            header = os.date(),
            items = {
              {
                action = "enew",
                name = "n --- new file",
                section = "open things",
              },
              {
                action = "Telescope find_files",
                name = "f --- find files",
                section = "open things",
              },
              {
                action = "Telescope oldfiles",
                name = "r --- recent files",
                section = "open things",
              },
              {
                action = "Telescope live_grep",
                name = "g --- grep grep",
                section = "open things",
              },
              {
                action = "Telescope file_browser",
                name = "b --- browse files",
                section = "open things",
              },
              {
                action = "checkhealth",
                name = "h --- all good??",
                section = "admin",
              },
              {
                action = "q!",
                name = "q --- get out of here",
                section = "admin",
              },
            },
          })
          require('mini.statusline').setup()
          require('mini.tabline').setup()
          END
        '';
      }

      {
        plugin = nvim-treesitter.withAllGrammars;
        config = ''
          lua << END
          require'nvim-treesitter.configs'.setup {
            -- disable parser installation via plugin
            -- managed by nix instead
            ensure_installed = { },
            sync_install = false,
            auto_install = false,
            highlight = { enable = true, },
          }
          END
        '';
      }

      {
        plugin = telescope-nvim;
        config = ''
          lua << END
            require('telescope').setup{
              extensions = {
                file_browser = { hijack_netrw = true, },
              },
            }
          END
        '';
      }
      plenary-nvim
      
      {
        plugin = telescope-project-nvim;
        config = ''
          lua << END
            require'telescope'.load_extension('project')
          END
        '';
      }
      
      {
        plugin = telescope-file-browser-nvim;
        config = ''
          lua << END
            require'telescope'.load_extension('file_browser')
          END
        '';
      }

      {
        plugin = which-key-nvim;
        config = ''
          lua << END
            require("which-key").setup {}
          END
        '';
      }

      {
        plugin = nvim-lspconfig;
        config = ''
          lua << END
            require('lspconfig').pyright.setup {}
            require('lspconfig').lua_ls.setup{}
            require('lspconfig').bashls.setup{}
            require('lspconfig').gopls.setup{}
          END
        '';
      }
    ];
  };

  home.stateVersion = "22.11";



  
}
