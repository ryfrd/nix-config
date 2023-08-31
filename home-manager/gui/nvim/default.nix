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
            require('lspconfig').rnix.setup{}
            require('lspconfig').bashls.setup{}
            require('lspconfig').gopls.setup{}
          END
        '';
      }
    ];
  };

  home.packages = with pkgs; [
    gcc
    nodePackages.pyright
    nodePackages.bash-language-server
    luaPackages.lua-lsp
    rnix-lsp
    gopls
  ];
}
