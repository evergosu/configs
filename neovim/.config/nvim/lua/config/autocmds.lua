local function augroup(name)
  return vim.api.nvim_create_augroup('custom_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup('user_lsp_config'),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>Lwa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>Lwr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>Lwl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>LD', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>Lrn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>Lca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>Lf', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Makes sure that any opened buffer which is contained in a git repo will be tracked.
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('track_repos'),
  command = ':lua require("lazygit.utils").project_root_dir()',
})

-- Check if any buffers were changed outside of Vim.
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  command = 'checktime',
})

-- Highlight on yank.
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank({
      timeout = 200,
    })
  end,
})

-- Resize splits if window got resized.
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Close some filetypes with <q>.
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'help',
    'man',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Create intermediate directory if it does not exist when saving a file.
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
