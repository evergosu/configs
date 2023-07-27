local function augroup(name)
  return vim.api.nvim_create_augroup('custom_' .. name, { clear = true })
end

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
