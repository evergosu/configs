local map = require('config.manager').map

-- Unmap <space> to use as leader key.
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Emulate <esc> with movement.
map('i', 'kj', '<esc>', { silent = true })

-- TODO: Temporary file actions.
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "[Q]uit all" })
map('n','<leader>fn', '<cmd>enew<cr>', { desc = '[F]ile [N]ew' })
map('n', '<leader>fw', '<cmd>write<cr>', { desc = '[F]ile [W]rite' })
map('n', '<leader>fq', '<cmd>q!<cr>', { desc = '[F]ile [Q]uit' })
map({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Better copy-paste and deletion.
map('v', 'p', '"_dP')
map("n", "x", '"_x')

-- Better up/down.
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Better indenting.
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Clear search with <esc>.
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })
map('n', '<leader>h', ':h <c-r><c-w><cr>', { desc = 'Help'})

-- Clear search, diff update and redraw.
map('n',
  '<leader>ur',
  '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
  { desc = 'Redraw / clear hlsearch / diff update' })

-- Move lines.
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Resize window.
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Split window.
map("n", "<leader>sv", "<C-w>v", { desc = "[S]plit window - [V]ertically", remap = true })
map("n", "<leader>sh", "<C-w>s", { desc = "[S]plit window - [H]orizontally", remap = true })
map("n", "<leader>se", "<C-w>=", { desc = "[S]plit window - [E]qualize", remap = true })
map("n", "<leader>sc", "<C-w>c", { desc = "[S]plit window - [C]lose", remap = true })
map("n", "<leader>sm", "<cmd>lua require('maximize').toggle()<cr>", { desc = "[S]plit window - [M]aximize", remap = true })

-- Move to window.
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Lazy package manager.
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- Buffers.
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
map('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })
map('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })

-- Tabs.
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
