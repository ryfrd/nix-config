local keymap = vim.keymap
local g = vim.g
local api = vim.api


-- map leader to space
keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
g.mapleader = " "

-- telescope
keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<cr>', {})
keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', {})
keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>', {})
keymap.set('n', '<leader>pp', '<cmd>Telescope projects<cr>', {})

-- buffers
keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', {})
keymap.set('n', '<leader>bh', '<cmd>bprevious<cr>', {})
keymap.set('n', '<leader>bl', '<cmd>bdelete<cr>', {})

--tabs
keymap.set('n', '<leader>tt', '<cmd>tabnew<cr>', {})
keymap.set('n', '<leader>tn', '<cmd>tabnext<cr>', {})
keymap.set('n', '<leader>tp', '<cmd>tabprevious<cr>', {})
keymap.set('n', '<leader>tq', '<cmd>tabclose<cr>', {})

-- splits
keymap.set('n', '<leader>sh', '<cmd>split<cr>', {})
keymap.set('n', '<leader>sv', '<cmd>vsplit<cr>', {})

-- move focus
keymap.set('n', '<leader>h', '<C-W>h', {})
keymap.set('n', '<leader>j', '<C-W>j', {})
keymap.set('n', '<leader>k', '<C-W>k', {})
keymap.set('n', '<leader>l', '<C-W>l', {})
keymap.set('n', '<leader>q', '<C-W>q', {})
