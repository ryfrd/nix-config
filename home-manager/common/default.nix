{ lib, config, pkgs, nix-colors, ... }: {

  home.packages = with pkgs; [

    eza
    ripgrep
    fd
    curl
    wget
    tree
    dua
    htop
    pfetch
    dig

    fishPlugins.z
    fishPlugins.autopair
    fishPlugins.done
    fishPlugins.sponge

  ];

  programs.home-manager.enable = true;
  home = {
    username = "james";
    homeDirectory = "/home/james";
  };
  home.stateVersion = "22.11";

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
      "c" = "clear && cd";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
    };
    functions = {
      twitch = "${pkgs.streamlink}/bin/streamlink https://twitch.tv/$argv[1] best -p mpv";
      port = "sudo netstat -tulpn | grep $argv[1]";
      cdir = "mkdir $argv[1] && cd $argv[1]";
      ssht = "ssh $argv -t 'tmux new -A'";
    };
  };
  home.sessionVariables = {
    PF_INFO = "os kernel uptime memory shell editor palette";
  };

  programs.git = {
    enable = true;
    userName = "ryfrd";
    userEmail = "jdysmcl@tutanota.com";
  };

  programs.ranger = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    disableConfirmationPrompt = true;
    extraConfig = ''

      unbind C-b
      set -g prefix C-x

      bind-key Enter new-window

      bind-key - split-window -v
      bind-key | split-window -h

      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key k select-pane -U
      bind-key j select-pane -D

      bind-key h resize-pane -L 10
      bind-key l resize-pane -R 10
      bind-key k resize-pane -U 10
      bind-key j resize-pane -D 10

      set -g status-style bg=black
      set -g window-status-current-style bg=cyan,fg=black

    '';
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
      keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', {})
      keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {})
      keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>', {})

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
          require('mini.comment').setup()
          require('mini.indentscope').setup()
          require('mini.pairs').setup()

          local handle = io.popen('fortune -s')
          local meat = handle:read("*a")
          handle:close()
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
        plugin = which-key-nvim;
        config = ''
          lua << END
            require("which-key").setup {}
          END
        '';
      }

    ];
  };


}
