--
-- OPTIONS
--

local opt = vim.opt

local opt = vim.opt

opt.autowrite = true -- Enable auto write

if not vim.env.SSH_TTY then
  opt.clipboard = "unnamedplus" -- Sync with system clipboard
end

opt.completeopt = "menu,menuone,noselect"
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
opt.smartindent = true -- Insert indents automatically
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
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

--
-- AUTOCMDS
--

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
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

-- Auto create dir when saving a file, in case some intermediate directory does not exist
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   group = augroup("auto_create_dir"),
--   callback = function(event)
--     if event.match:match("^%w%w+:[\\/][\\/]") then
--       return
--     end
--     local file = vim.uv.fs_realpath(event.match) or event.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
--   end,
-- })

--
-- KEYS
--

local keymap = vim.keymap

-- map leader to space
keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- manage files
keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', {})
keymap.set('n', '<leader>gg', '<cmd>Telescope live_grep<cr>', {})
keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
keymap.set("n", "<space>fd", ":Telescope fd<CR>")

-- buffers
keymap.set('n', '<leader>ba', '<cmd>Telescope buffers<cr>', {})
keymap.set('n', '<leader>bb', '<cmd>bnext<cr>', {})
keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', {})
keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', {})

-- splits
keymap.set('n', '<leader>-', '<cmd>split<cr>', {})
keymap.set('n', '<leader>|', '<cmd>vsplit<cr>', {})

-- move focus
keymap.set('n', '<leader>h', '<C-W>h', {})
keymap.set('n', '<leader>j', '<C-W>j', {})
keymap.set('n', '<leader>k', '<C-W>k', {})
keymap.set('n', '<leader>l', '<C-W>l', {})

--
-- PLUGINS
--

require('mini.align').setup({})
require('mini.comment').setup({})
require('mini.pairs').setup({})
require('mini.indentscope').setup({})
require('mini.statusline').setup({})

require('bufferline').setup({})

require('nvim-treesitter.configs').setup({
  -- disable parser installation via plugin
  -- managed by nix instead
  ensure_installed = { },
  sync_install = false,
  auto_install = false,
  highlight = { enable = true, },
})

require('telescope').setup({})
