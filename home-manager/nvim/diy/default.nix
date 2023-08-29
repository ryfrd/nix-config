{ config, pkgs, lib, ... }:
let
  c = config.colorscheme.colors;
in
{
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
      vim.cmd('set tabstop=4')
      vim.cmd('set softtabstop=4')
      vim.cmd('set shiftwidth=4')
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
      plenary-nvim # required by telescope
      
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
        plugin = alpha-nvim;
        config = ''
          lua << END
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = "oh how i adore to edit text with neovim!"

            dashboard.section.buttons.val = {
              dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
              dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
              dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
              dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
              dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
              dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }

            local handle = io.popen('fortune')
            local result = handle:read("*a")
            handle:close()
            dashboard.section.footer.val = "\n" .. result

            for _, button in ipairs(dashboard.section.buttons.val) do
              button.opts.hl = "AlphaButtons"
              button.opts.hl_shortcut = "AlphaShortcut"
            end

            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 8

            require'alpha'.setup(require'alpha.themes.dashboard'.config)
          END
        '';
      }
      
      {
        plugin = mini-nvim;
        config = ''
          lua << END
            require('mini.align').setup()
            require('mini.base16').setup({
              palette = {
                base00 = '#${c.base00}';    
                base01 = '#${c.base01}';    
                base02 = '#${c.base02}';    
                base03 = '#${c.base03}';    
                base04 = '#${c.base04}';    
                base05 = '#${c.base05}';
                base06 = '#${c.base06}';    
                base07 = '#${c.base07}';    
                base08 = '#${c.base08}';    
                base09 = '#${c.base09}';   
                base0A = '#${c.base0A}';    
                base0B = '#${c.base0B}';    
                base0C = '#${c.base0C}';   
                base0D = '#${c.base0D}';
                base0E = '#${c.base0E}';
                base0F = '#${c.base0F}';    
              },
            })
            require('mini.comment').setup()
            require('mini.indentscope').setup()
            require('mini.pairs').setup()
            require('mini.statusline').setup({
            })
            require('mini.tabline').setup()
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
            require('lspconfig').rnix.setup{}
            require('lspconfig').bashls.setup{}
            require('lspconfig').gopls.setup{}
          END
        '';
      }
    ];
  };

  home.packages = with pkgs; [
    xclip
    wl-clipboard
    gcc
    fortune
    nodePackages.pyright
    nodePackages.bash-language-server
    luaPackages.lua-lsp
    rnix-lsp
    gopls
  ];
}
