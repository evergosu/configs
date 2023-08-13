local map = require('config.manager').map

-- Unmap <space> to use as leader key.
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Emulate <esc> with movement.
map('i', 'kj', '<esc>', { silent = true })

-- TODO: Temporary file actions.
map({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })

-- Better copy-paste and deletion.
map('n', 'x', '"_x', { desc = 'Delete into void registry' })
map('v', 'p', '"_dP', { desc = '[P]aste into void registry' })
map('n', '<leader>d', '"_d', { desc = '[D]elete into void registry' })
map('v', '<leader>d', '"_d', { desc = '[D]elete into void registry' })
map('n', '<leader>y', '"+y', { desc = '[Y]ank into system clipboard' })
map('v', '<leader>y', '"+y', { desc = '[Y]ank into system clipboard' })
map('n', '<leader>p', '"+p', { desc = '[P]aste from system clipboard' })
map('v', '<leader>p', '"+p', { desc = '[P]aste from system clipboard' })

-- Replace by word without lsp.
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]replace word' })

-- Better up/down.
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Better indenting.
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Clear search with <esc>.
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })
map('n', '<leader>?', ':h <c-r><c-w><cr>', { desc = 'Help' })

-- Clear search, diff update and redraw.
map(
  'n',
  '<leader>ur',
  '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
  { desc = 'Redraw / clear hlsearch / diff update' }
)

-- Move lines.
map('v', '<S-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
map('v', '<S-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Resize window.
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Move to window.
map('n', '<C-h>', '<C-w>w', { desc = '[H]op to next window', remap = true })
map('n', '<C-l>', '<C-w>p', { desc = '[H]op to [L]ast window', remap = true })

-- Center scrolls.
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll [D]own and center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll [U]p and center' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Lazy package manager.
map('n', '<leader>L', '<cmd>Lazy<cr>', { desc = '[L]azy plugin manager' })

-- Buffers.
map('n', '<S-h>', '<cmd>:bnext<cr>', { desc = '[H]op to next buffer' })
map('n', '<S-l>', '<cmd>e #<cr>', { desc = 'Hop to [L]ast buffer' })
map('n', '<leader>D', [[<cmd>:%bd|e#|bd#<cr>|'"]], { desc = '[D]elete all buffers except current' })

-- Tabs.
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- Quickfix and Loclist navigation.
map('n', '<C-k>', '<cmd>cnext<cr>zz', { desc = 'Next quickfix item' })
map('n', '<C-j>', '<cmd>cprev<cr>zz', { desc = 'Prev quickfix item' })
map('n', '<leader>k', '<cmd>lnext<cr>zz', { desc = 'Next loclist item' })
map('n', '<leader>j', '<cmd>lprev<cr>zz', { desc = 'Prev loclist item' })
