{ pkgs, config, ... }: {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # lua
      stylua
      # python
      black
      # nodePackages.pyright
      #nix
      nixfmt-classic
      nil
    ];
    extraLuaConfig = ''
      -- options
      local opt = vim.opt

      opt.autowrite = true -- Enable auto write

      if not vim.env.SSH_TTY then
        opt.clipboard = "unnamedplus" -- Sync with system clipboard
      end

      opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
      opt.confirm = true -- Confirm to save changes before exiting modified buffer
      opt.cursorline = true -- Enable highlighting of the current line
      opt.expandtab = true -- Use spaces instead of tabs
      opt.formatoptions = "jcroqlnt" -- tcqj
      opt.grepformat = "%f:%l:%c:%m"
      opt.grepprg = "rg --vimgrep"
      opt.ignorecase = true -- Ignore case
      opt.inccommand = "nosplit" -- preview incremental substitute
      opt.laststatus = 3 -- global statusline
      opt.list = true -- Show some invisible characters (tabs...
      opt.mouse = "a" -- Enable mouse mode
      opt.number = true -- Print line number
      opt.pumblend = 10 -- Popup blend
      opt.pumheight = 10 -- Maximum number of entries in a popup
      opt.relativenumber = true -- Relative line numbers
      opt.scrolloff = 4 -- Lines of context
      opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
      opt.shiftround = true -- Round indent
      opt.shiftwidth = 2 -- Size of an indent
      opt.shortmess:append({ W = true, I = true, c = true, C = true })
      opt.showmode = false -- Dont show mode since we have a statusline
      opt.sidescrolloff = 8 -- Columns of context
      opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
      opt.smartcase = true -- Don't ignore case with capitals
      opt.smartindent = false -- Insert indents automatically
      opt.spelllang = { "en" }
      opt.splitbelow = true -- Put new windows below current
      opt.splitkeep = "screen"
      opt.splitright = true -- Put new windows right of current
      opt.tabstop = 2 -- Number of spaces tabs count for
      opt.termguicolors = true -- True color support
      if not vim.g.vscode then
        opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
      end
      opt.undofile = true
      opt.undolevels = 10000
      opt.updatetime = 200 -- Save swap file and trigger CursorHold
      opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
      opt.wildmode = "longest:full,full" -- Command-line completion mode
      opt.winminwidth = 5 -- Minimum window width
      opt.wrap = false -- Disable line wrap

      -- keys
      local keymap = vim.keymap

      -- map leader to space
      keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
      vim.g.mapleader = " "

      -- manage files
      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {})
      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", {})
      keymap.set("n", "<leader>gg", "<cmd>Telescope live_grep<cr>", {})
      keymap.set("n", "<space>fb", "<cmd>Oil<CR>")
      keymap.set("n", "<space>fd", ":Telescope fd<CR>")

      -- buffers
      keymap.set("n", "<leader>ba", "<cmd>Telescope buffers<cr>", {})
      keymap.set("n", "<leader>bb", "<cmd>bnext<cr>", {})
      keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", {})
      keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", {})

      -- splits
      keymap.set("n", "<leader>-", "<cmd>split<cr>", {})
      keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", {})

      -- move focus
      keymap.set("n", "<leader>h", "<C-W>h", {})
      keymap.set("n", "<leader>j", "<C-W>j", {})
      keymap.set("n", "<leader>k", "<C-W>k", {})
      keymap.set("n", "<leader>l", "<C-W>l", {})

      -- autocmd
      local function augroup(name)
        return vim.api.nvim_create_augroup("vim" .. name, { clear = true })
      end

      -- Highlight on yank
      vim.api.nvim_create_autocmd("TextYankPost", {
        group = augroup("highlight_yank"),
        callback = function()
          vim.highlight.on_yank()
        end,
      })

      -- resize splits if window got resized
      vim.api.nvim_create_autocmd({ "VimResized" }, {
        group = augroup("resize_splits"),
        callback = function()
          local current_tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. current_tab)
        end,
      })
    '';
    plugins = with pkgs.vimPlugins; [
      # deps
      nvim-web-devicons
      plenary-nvim

      {
        plugin = mini-nvim;
        config = ''
          lua << EOF
            require('mini.base16').setup({
              palette = {
                base00 = '#${config.colorScheme.palette.base00}',
                base01 = '#${config.colorScheme.palette.base01}',
                base02 = '#${config.colorScheme.palette.base02}',
                base03 = '#${config.colorScheme.palette.base03}',
                base04 = '#${config.colorScheme.palette.base04}',
                base05 = '#${config.colorScheme.palette.base05}',
                base06 = '#${config.colorScheme.palette.base06}',
                base07 = '#${config.colorScheme.palette.base07}',
                base08 = '#${config.colorScheme.palette.base08}',
                base09 = '#${config.colorScheme.palette.base09}',
                base0A = '#${config.colorScheme.palette.base0A}',
                base0B = '#${config.colorScheme.palette.base0B}',
                base0C = '#${config.colorScheme.palette.base0C}',
                base0D = '#${config.colorScheme.palette.base0D}',
                base0E = '#${config.colorScheme.palette.base0E}',
                base0F = '#${config.colorScheme.palette.base0F}',
              }
            })
            require('mini.statusline').setup()
            require('mini.tabline').setup()
            require('mini.align').setup()
            require('mini.pairs').setup()
            require('mini.indentscope').setup()
          EOF
        '';
      }
      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
            require("lspconfig").pyright.setup({})
          EOF
        '';
      }
      {
        plugin = conform-nvim;
        config = ''
          lua << EOF
            require("conform").setup({
              formatters_by_ft = {
                lua = { "stylua" },
                nix = { "nixfmt" },
                python = { "black" },
              },
              format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
              },
            })
          EOF
        '';
      }
      {
        plugin = which-key-nvim;
        config = ''
          lua << EOF
            require("which-key").setup()
          EOF
        '';
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = ''
          lua << EOF
            require('nvim-treesitter.configs').setup({
              ensure_installed = {},

              -- Install parsers synchronously (only applied to `ensure_installed`)
              sync_install = false,

              -- Automatically install missing parsers when entering buffer
              -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
              auto_install = false,

              highlight = {
                enable = true,
                disable = { },
                additional_vim_regex_highlighting = false,
              },
            })
          EOF
        '';
      }
      {
        plugin = vim-illuminate;
        config = ''
          lua << EOF
            require("illuminate").configure()
          EOF
        '';
      }
      {
        plugin = nvim-highlight-colors;
        config = ''
          lua << EOF
            require("nvim-highlight-colors").setup()
          EOF
        '';
      }
      {
        plugin = telescope-nvim;
        config = ''
          lua << EOF
            require("telescope").setup()
          EOF
        '';
      }
      {
        plugin = oil-nvim;
        config = ''
          lua << EOF
            require("oil").setup()
          EOF
        '';
      }
      {
        plugin = nvim-cmp;
        config = ''
          lua << EOF
            local cmp = require('cmp')
            cmp.setup({
              mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
              }),
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
              }),
            })
          EOF
        '';
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
    ];
  };
}
